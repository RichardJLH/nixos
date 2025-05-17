{ pkgs, ... }:
{
  users.users.richard = {
    isNormalUser = true;
    description = "Richard H";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };
}
