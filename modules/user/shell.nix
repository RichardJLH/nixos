{
  programs.zsh = {
    enable = true;
    autocd = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch = {
      enable = true;
      searchDownKey = [ "$terminfo[kcud1]" ];
      searchUpKey = [ "$terminfo[kcuu1]" ];
    };

    prezto = {
      enable = true;
      tmux.autoStartLocal = true;
    };
  };

  home.shellAliases = {
    a = "doas";
    c = "clear";
  };
}
