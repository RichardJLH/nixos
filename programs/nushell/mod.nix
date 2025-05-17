{
  programs.nushell = {
    enable = true;
    envFile.source = ./configuration/env.nu;
    shellAliases = {
      a = "doas";
      c = "clear";
    };
  };
}
