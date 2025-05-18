{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  hardware.cpu.amd.updateMicrocode = true;
  security.polkit.enable = true;
  time.timeZone = "Europe/Berlin";

  console.useXkbConfig = true;

  programs.git.enable = true;
  programs.steam.enable = true;

  services.printing.enable = true;  # cups
  services.fprintd.enable = true;  # fingerprint
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
  environment.systemPackages = [ pkgs.doas-sudo-shim ];

  system.stateVersion = "23.11";
}
