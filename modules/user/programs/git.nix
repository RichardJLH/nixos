{
  programs.git = {
    enable = true;

    userName = "Richard Hildebrandt";
    userEmail = "richard.jl.hildebrandt@gmail.com";

    signing = {
      signByDefault = true;
    };

    extraConfig = {
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
  home.shellAliases.g = "git";
}
