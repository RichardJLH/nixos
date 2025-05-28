{ config, pkgs, inputs, ... }:

let
  driveName = "Google Drive";
in
{
  programs.rclone = {
    enable = true;
    remotes = {
      gdrive = {
        config = {
          type = "drive";

        };
      };
    };
  };

  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Mount Google Drive with rclone";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: ${config.home.homeDirectory}/${driveName} \
          --vfs-cache-mode writes \
          --allow-other
      '';
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u ${config.home.homeDirectory}/${driveName}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.file."${driveName}".directory = { };
}
