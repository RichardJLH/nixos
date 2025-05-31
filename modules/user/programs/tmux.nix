{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;
    mouse = true;
    prefix = "C-Space";
    escapeTime = 0;
    terminal = "screen-256color";
    extraConfig = "set-option -g repeat-time 0";
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      yank
      pass
      tmux-fzf
    ];
  };
}
