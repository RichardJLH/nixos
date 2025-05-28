{
  programs.git = {
    enable = true;

	userName = "RichardJLH";
	userEmail = "richard.jl.hildebrandt@gmail.com";

    extraConfig = {
      commit.gpgsign = true;
      safe.directory = "*";
    };
    delta.enable = true;
    aliases = {
      a = "add -A";
      c = "commit -m";
      d = "diff";
      l = "log";
      p = "push";
      r = "revert";
      s = "status";
      ac = "!git add -A && git commit -m";
    };
  };
  programs.nushell.shellAliases.g = "git";
}
