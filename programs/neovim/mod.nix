{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
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
    "nvim" = {
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
