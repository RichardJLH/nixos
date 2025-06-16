{pkgs, ...}: {
  programs = {
    mpv = {
      enable = true;
      config = {
        script-opts = "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp";
      };
    };
    yt-dlp.enable = true;
  };
}
