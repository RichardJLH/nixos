{
  programs.qutebrowser = {
    enable = true;
    enableDefaultBindings = false;

    keyBindings = {
      normal = {
        "n" = "scroll down";
        "e" = "scroll up";
        "i" = "scroll left";
        "o" = "scroll right";
        "N" = "tab-next";
        "E" = "tab-prev";
        "I" = "back";
        "O" = "forward";
        "<Ctrl-B>" = "scroll-page 0 -1";
        "<Ctrl-U>" = "scroll-page 0 -0.5";
        "<Ctrl-D>" = "scroll-page 0 0.5";
        "<Ctrl-F>" = "scroll-page 0 1";
        "gg" = "scroll-to-perc 0";
        "G" = "scroll-to-perc 100";
        "<=>" = "zoom-in";
        "<->" = "zoom-out";
        "f" = "hint";
        "m" = "set-mark";
        "/" = "cmd-set-text -s :search";
        "[" = "search-next";
        "]" = "search-prev";

        "d" = "tab-close";
        "u" = "undo";

        "y" = "yank pretty-url";

        "t1" = "tab-focus 1";
        "t2" = "tab-focus 2";
        "t3" = "tab-focus 3";
        "t4" = "tab-focus 4";
        "t5" = "tab-focus 5";
        "t6" = "tab-focus 6";
        "t7" = "tab-focus 7";
        "t8" = "tab-focus 8";
        "t9" = "tab-focus 9";
        "t0" = "tab-focus 10";
        "t$" = "tab-focus -1";
        "ts" = "tab-focus stack-prev";
        "tS" = "tab-focus stack-next";
        "tn" = "open -t";
        "tm" = "tab-mute";

        "r" = "reload";
        "R" = "reload -f";

        "l" = "cmd-set-text -s :open";
        "L" = "cmd-set-text -s :open -t";

        "h" = "mode-enter insert";
        ";" = "cmd-set-text :";

        ",m" = "hint links spawn mpv {hint-url}";
        ",M" = "spawn mpv {url}";
      };
      command = {
        "<Escape>" = "mode-leave";
        "<Return>" = "command-accept";

        "<Shift-Tab>" = "completion-item-focus prev";
        "<Tab>" = "completion-item-focus next";
        "<Up>" = "completion-item-focus --history prev";
        "<Down>" = "completion-item-focus --history next";

        "<Ctrl-Y>" = "rl-yank";
        "<Ctrl-P>" = "command-history-previous";
        "<Ctrl-N>" = "command-history-next";

        "<Ctrl-B>" = "rl-backward-word";
        "<Ctrl-Shift-B>" = "rl-forward-word";
        "<Ctrl-A>" = "rl-beginning-of-line";
        "<Ctrl-E>" = "rl-end-of-line";
        "<Ctrl-W>" = "rl-backward-kill-word";
        "<Ctrl-Shift-W>" = "rl-kill-word";
        "<Ctrl-U>" = "rl-kill-line";
      };
      insert = {
        "<Escape>" = "mode-leave";
      };
      yesno = {
        "<Escape>" = "mode-leave";
        "y" = "prompt-accept yes";
        "n" = "prompt-accept no";
        "Y" = "prompt-accept --save yes";
        "N" = "prompt-accept --save no";
      };
      prompt = {
        "<Escape>" = "mode-leave";
      };
    };
    searchEngines = {
      g = "https://www.google.com/search?hl=en&q={}";
      y = "https://www.youtube.com/results?search_query={}";
      DEFAULT = "https://www.google.com/search?hl=en&q={}";
    };
    settings = {
      url.start_pages = "https://www.google.com";
      auto_save.session = true;
      content.blocking.method = "adblock";
    };
  };

  programs.mpv.enable = true;
}
