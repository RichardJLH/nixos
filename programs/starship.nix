{ config, pkgs, catppuccin, ... }:

{
  programs.starship = {
    enable = true;
    catppuccin.enable = true;
  };
}
