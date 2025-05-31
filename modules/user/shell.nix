{
  programs.zsh = {
    enable = true;
    autocd = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    historySubstringSearch.searchDownKey = [ "$terminfo[kcud1]" ];
    historySubstringSearch.searchUpKey = [ "$terminfo[kcuu1]" ];
  };

  home.shellAliases = {
    a = "doas";
    c = "clear";
  };
}
