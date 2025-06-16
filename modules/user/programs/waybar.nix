{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["battery" "pulseaudio"];
        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          interval = 1;
        };
        pulseaudio = {
          on-click = "pavucontrol";
        };
      };
    };
  };
}
