{pkgs, ...}: let
  device = "/dev/disk/by-uuid/edd92a3a-984c-4364-8684-69dfb6edd936";
  fsType = "btrfs";
in {
  fileSystems."/" = {
    inherit device fsType;
    options = ["subvol=@" "compress=zstd" "noatime" "space_cache=v2" "ssd"];
  };

  fileSystems."/home" = {
    inherit device fsType;
    options = ["subvol=@home" "compress=zstd" "noatime" "space_cache=v2" "ssd"];
  };

  fileSystems."/nix" = {
    inherit device fsType;
    options = ["subvol=@nix" "compress=zstd" "noatime" "space_cache=v2" "ssd"];
  };

  fileSystems."/var/log" = {
    inherit device fsType;
    options = ["subvol=@var_log" "noatime" "space_cache=v2" "ssd"];
  };

  fileSystems."/.snapshots" = {
    inherit device fsType;
    options = ["subvol=@snapshots" "noatime" "space_cache=v2" "ssd"];
  };

  # net drive
  boot.supportedFilesystems = ["cifs"];
  systemd.mounts = [
    {
      description = "Leannas cifs share";
      what = "//10.1.0.11/Transfer";
      where = "/home/richard/leannas";
      type = "cifs";
      options = "credentials=/home/richard/nixos/secrets/leannas.credentials,rw,uid=1000,gid=1000";
      wantedBy = ["multi-user.target"];
    }
  ];
  environment.systemPackages = [pkgs.cifs-utils];
}
