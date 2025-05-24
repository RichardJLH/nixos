{ pkgs, ... }:

{
  programs.neovim = {
    enable = false;
    defaultEditor = true;

    extraLuaPackages = luaPkgs: with luaPkgs; [ jsregexp ];
    extraPackages = with pkgs; [
      nil
      lua-language-server
      ripgrep
      fd
	  fzf
	  curl
    ];
  };

  xdg.configFile = {
    "neovim-old" = {
      source = ./configuration;
      recursive = true;
    };
  };

  home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
  };

  programs.nushell.shellAliases.e = "nvim";
}
