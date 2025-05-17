{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    prefix = "C-Space";
    escapeTime = 0;
    terminal = "screen-256color";
	extraConfig = "set-option -sa terminal-features ',xterm-kitty:RGB'";
  };
}
