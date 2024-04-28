{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  xdg.configFile."nvim" = {
    source = ./neovim;
    recursive = true;
  };
}
