{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

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
  # services.kmscon = {
  #   enable = true;
    # hwRender = true;
    # fonts = [{ name = "MesloLGS NF Regular"; package = pkgs.meslo-lgs-nf; }];
    # extraConfig = ''
    #   font-size=19
    #   xkb-layout=us
    #   xkb-variant=colemak
    # '';
  # };
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

  # networking
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  console.useXkbConfig = true;
  i18n.defaultLocale = "en_US.UTF-8";
  programs.git.enable = true;
  programs.steam.enable = true;

  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # fingerprint
  services.fprintd.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    usbutils
    refind
    efibootmgr
    cifs-utils
    doas-sudo-shim
    llvmPackages_latest.lldb
    llvmPackages_latest.clang
    valgrind
  ];
  fonts.packages = with pkgs; [ meslo-lgs-nf ];

  system.stateVersion = "23.11";
}
