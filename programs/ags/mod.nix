{ pkgs, ... }:

{
  home.packages = [ pkgs.ags ];
  xdg.configFile = {
    "ags" = {
      source = ./configuration;
      recursive = true;
    };
  };
}
