{
  description = "NixOS configuration of Richard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.3.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    firefox-addons,
    nixvim,
    stylix,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations."richard-laptop-nixos" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = inputs;
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix

        ./modules/system/bluetooth.nix
        ./modules/system/bootloader.nix
        ./modules/system/filesystem.nix
        ./modules/system/display.nix
        ./modules/system/audio.nix
        ./modules/system/networking.nix
        ./modules/system/users.nix
        ./modules/system/stylix.nix

        stylix.nixosModules.stylix

        # lanzaboote.nixosModules.lanzaboote
        # ({ pkgs, lib, ... }: {
        #
        #   # For debugging and troubleshooting Secure Boot.
        #   environment.systemPackages = [ pkgs.sbctl ];
        #
        #   # Lanzaboote currently replaces the systemd-boot module.
        #   # This setting is usually set to true in configuration.nix
        #   # generated at installation time. So we force it to false
        #   # for now.
        #   boot.loader.systemd-boot.enable = lib.mkForce false;
        #
        #   boot.lanzaboote = {
        #     enable = true;
        #     pkiBundle = "/etc/secureboot";
        #   };
        # })
      ];
    };
    homeConfigurations.richard = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};
      modules = [
        stylix.homeModules.stylix

        ./home.nix
        ./modules/user/stylix.nix
        ./modules/user/programs.nix
        ./modules/user/pass.nix
        ./modules/user/shell.nix
      ];
    };
    formatter.${system} = pkgs.nixpkgs-fmt;
  };
}
