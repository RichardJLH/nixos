{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
    (writeScriptBin "swww-diashow" (builtins.readFile ./scripts/swww-diashow))
  ];
}
