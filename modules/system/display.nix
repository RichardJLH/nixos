{
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
}
