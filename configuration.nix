{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  hardware.cpu.amd.updateMicrocode = true;
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };
  services.geoclue2 = {
    enable = true;
    appConfig.gammastep = {
      isAllowed = true;
      isSystem = true;
      users = [ "1000" ];
    };
  };
  security.polkit.enable = true;

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "richard" ];
        keepEnv = true;
        persist = true;  
      }];
    };
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  console.useXkbConfig = true;
  programs.git.enable = true;
  programs.steam.enable = true;

  services.printing.enable = true;  # cups
  services.fprintd.enable = true;  # fingerprint

  environment.systemPackages = [ pkgs.doas-sudo-shim ];

  system.stateVersion = "23.11";
}
