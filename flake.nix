{
  description = "NixOS configuration of Richard";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	# lanzaboote = {
 #      url = "github:nix-community/lanzaboote/v0.3.0";
 #      inputs.nixpkgs.follows = "nixpkgs";
 #    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, home-manager, /* lanzaboote, */ catppuccin, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."richard-laptop-nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          ./configuration.nix

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
      homeConfigurations."richard" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          catppuccin.homeManagerModules.catppuccin
        ];
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
