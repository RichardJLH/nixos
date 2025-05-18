{
  programs.nixvim.enable = true;

  programs.nixvim.package = null;
  home.packages = [
    (pkgs.writeShellScriptBin "nixvim" ''
     exec ${config.programs.nixvim.finalPackage}/bin/nvim "$@"
     '')
  ];

}
