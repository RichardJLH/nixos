{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "richard";
    homeDirectory = "/home/richard";
    stateVersion = "23.11";

	keyboard = {
      layout = "us";
      variant = "colemak";
	};

    packages = with pkgs; [
      neofetch
      brightnessctl
      pavucontrol
      tor-browser
      socat
      plocate
      sbctl
	  chromium
	  clang-tools
	  gparted
	  unzip
	  cacert
      jetbrains.idea-community-bin
      nerd-fonts.jetbrains-mono

      (pkgs.stdenvNoCC.mkDerivation {
         name = "font-awesome-pro";
         src = builtins.path {
           path = ./assets/font-awesome;
           name = "font-awesome-src";
         };
         installPhase = ''
         mkdir -p $out/share/fonts/opentype
         cp *.otf $out/share/fonts/opentype/
         '';
       })


      # unfree packages
      spotify
      whatsapp-for-linux
      steam-run
    ];
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
