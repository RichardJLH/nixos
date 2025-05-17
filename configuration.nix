# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
    device = "/dev/disk/by-uuid/edd92a3a-984c-4364-8684-69dfb6edd936";
    fsType = "btrfs";
in
{
  imports = [ ./hardware-configuration.nix ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fileSystems."/" = {
    inherit device fsType;
    options = [ "subvol=@" "compress=zstd" "noatime" "space_cache=v2" "ssd" ];
  };

  fileSystems."/home" = {
    inherit device fsType;
    options = [ "subvol=@home" "compress=zstd" "noatime" "space_cache=v2" "ssd" ];
  };

  fileSystems."/nix" = {
    inherit device fsType;
    options = [ "subvol=@nix" "compress=zstd" "noatime" "space_cache=v2" "ssd" ];
  };

  fileSystems."/var/log" = {
    inherit device fsType;
    options = [ "subvol=@var_log" "noatime" "space_cache=v2" "ssd" ];
  };

  fileSystems."/.snapshots" = {
    inherit device fsType;
    options = [ "subvol=@snapshots" "noatime" "space_cache=v2" "ssd" ];
  };


  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
        efiSysMountPoint = "/boot";
      };
      grub = {
        # despite what the configuration.nix manpage seems to indicate,
        # as of release 17.09, setting device to "nodev" will still call
        # `grub-install` if efiSupport is true
        # (the devices list is not used by the EFI grub install,
        # but must be set to some value in order to pass an assert in grub.nix)
        devices = [ "nodev" ];
        efiSupport = true;
        enable = true;
        # set $FS_UUID to the UUID of the EFI partition
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
              insmod fat
              insmod search_fs_uuid
              insmod chain
              search --fs-uuid --set=root $FS_UUID
              chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };
  };

  # powers up the default Bluetooth controller on boot
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.cpu.amd.updateMicrocode = true;
  services.blueman.enable = true;
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
  networking = {
      hostName = "richard-laptop-nixos";
      networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  console.useXkbConfig = true;
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # extraLocaleSettings = {
    #   LC_ADDRESS = "de_DE.UTF-8";
    #   LC_IDENTIFICATION = "de_DE.UTF-8";
    #   LC_MEASUREMENT = "de_DE.UTF-8";
    #   LC_MONETARY = "de_DE.UTF-8";
    #   LC_NAME = "de_DE.UTF-8";
    #   LC_NUMERIC = "de_DE.UTF-8";
    #   LC_PAPER = "de_DE.UTF-8";
    #   LC_TELEPHONE = "de_DE.UTF-8";
    #   LC_TIME = "de_DE.UTF-8";
    # };
  };

  # Enable the X11 windowing system.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "colemak";
    };
  };
  services.desktopManager.plasma6.enable = true;


  programs.hyprland.enable = true;
  programs.git.enable = true;
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
    flake = "${config.users.users.richard.home}/nixos";
  };
  programs.steam.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # fingerprint
  services.fprintd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.richard = {
    isNormalUser = true;
    description = "Richard H";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };

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

  boot.supportedFilesystems = [ "cifs" ];
  systemd.mounts = [{
    description = "Leannas cifs share";
    what = "//10.1.0.11/Transfer";
    where = "/home/richard/leannas";
    type = "cifs";
    options = "credentials=/home/richard/nixos/leannas.credentials,rw,uid=1000,gid=1000";
    wantedBy = [ "multi-user.target" ];
  }];

  system.stateVersion = "23.11";
}
