{ pkgs, ... }:

{
  imports = [
    ./eww/mod.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,auto";
      "$mainMod" = "SUPER";

      exec-once = "eww open bar & firefox";

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = "1";
      };

      general = {
        gaps_in = "5";
        gaps_out = "20";
        border_size = "2";

        layout = "dwindle";

        allow_tearing = false;
      };
      decoration = {
        blur = {
          enabled = "true";
          size = "3";
          passes = "1";
        };
      };

      animations = {
        enabled = "yes";

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        workspace_swipe = "true";
        workspace_swipe_distance = "200";
        workspace_swipe_invert = "false";
      };

	  windowrulev2 = [
		  "suppressevent maximize, class:.*"
		  "workspace 9, class:org.keepassxc.KeePassXC"
	  ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bind = [
        # apps
        "$mainMod, P, exec, rofi -show drun"
        "$mainMod CONTROL, Return, exec, kitty"
        "$mainMod CONTROL, F, exec, firefox"
        "$mainMod CONTROL, M, exec, dolphin"

        # navigation
        "$mainMod, i, movefocus, l"
        "$mainMod, o, movefocus, r"
        "$mainMod, e, movefocus, u"
        "$mainMod, n, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, K, workspace, empty"
        "$mainMod, S, workspace, e-1"
        "$mainMod, T, workspace, e+1"
        "$mainMod, R, togglespecialworkspace, magic"

        # modification
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, F, togglefloating,"
        "$mainMod SHIFT, S, togglesplit,"
        "$mainMod SHIFT, P, pseudo,"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT, S, movetoworkspace, e-1"
        "$mainMod SHIFT, T, movetoworkspace, e+1"
        "$mainMod SHIFT, R, movetoworkspace, special:magic"
        "$mainMod SHIFT, K, movetoworkspace, empty"

        # meta
        "$mainMod CONTROL SHIFT, Q, exit,"

        # f keys
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
      ];
    };
  };

  home.packages = with pkgs; [
    hyprcursor
    rofi-wayland
  ];
}
