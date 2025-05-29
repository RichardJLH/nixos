{
  programs.nushell = {
    enable = true;
    envFile.source = ./nushell/env.nu;
    shellAliases = {
      a = "doas";
      c = "clear";
    };
  };
  programs.zsh.enable = true;
}
