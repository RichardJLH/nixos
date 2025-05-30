{
  programs.nushell = {
    enable = true;
    envFile.source = ./nushell/env.nu;
    shellAliases = {
      a = "doas";
      c = "clear";
    };
	settings = {
	  show_banner = false;
	};
  };
  programs.zsh.enable = true;
}
