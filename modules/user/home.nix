{
  pkgs,
  fontAwesome,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "richard";
    homeDirectory = "/home/richard";

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
      unzip
      cacert
      jetbrains.idea-community-bin
      nerd-fonts.jetbrains-mono

      (pkgs.stdenvNoCC.mkDerivation {
        name = "font-awesome-pro";
        src = fontAwesome;
        installPhase = ''
          mkdir -p $out/share/fonts/opentype
          cp *.otf $out/share/fonts/opentype/
        '';
      })

      # unfree
      spotify
      whatsapp-for-linux
      steam-run
    ];
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
