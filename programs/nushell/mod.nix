{
  programs.nushell = {
    enable = true;
    configFile.source = ./configuration/config.nu;
    envFile.source = ./configuration/env.nu;
    shellAliases = {
      a = "doas";
      c = "clear";
    };
  };
}
