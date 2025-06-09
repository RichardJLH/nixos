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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    firefox-addons,
    nixvim,
    stylix,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    fontAwesome = self.packages.${system}.fontAwesome;
  in {
    packages.${system}.fontAwesome = builtins.path {
      path = ./assets/font-awesome;
      name = "font-awesome-src";
    };

    nixosConfigurations.richard-laptop-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./modules/system/hardware-configuration.nix
        ./modules/system/configuration.nix
        ./modules/system/bluetooth.nix
        ./modules/system/bootloader.nix
        ./modules/system/filesystem.nix
        ./modules/system/display.nix
        ./modules/system/audio.nix
        ./modules/system/networking.nix
        ./modules/system/users.nix
        ./modules/system/stylix.nix

        stylix.nixosModules.stylix
      ];
    };

    homeConfigurations.richard = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit fontAwesome firefox-addons nixvim;
      };
      modules = [
        ./modules/user/home.nix
        ./modules/user/stylix.nix
        ./modules/user/programs.nix
        ./modules/user/pass.nix
        ./modules/user/shell.nix

        stylix.homeModules.stylix
      ];
    };
  };
}
