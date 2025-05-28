{ pkgs, lib, ... }:
let
  wallpaperRepo = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "wallpaper";
    rev = "f2b8cc4223bcc2dfd5f165ab80f701bbb84e3303";
    # hash = lib.fakeSha256;
  };

  wallpaper = "${wallpaperRepo}/first-collection/nixos.png";
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

	image = "${wallpaper}";

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
