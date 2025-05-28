{
  imports = [
    ./programs/hyprland.nix
    ./programs/tmux.nix
    ./programs/nushell/mod.nix
    ./programs/gammastep.nix
    ./programs/bat.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
    ./programs/firefox.nix
    ./programs/lsd.nix
    ./programs/direnv.nix
	./programs/nh.nix
	./programs/nixvim.nix
	./programs/keepassxc.nix
	# ./programs/qutebrowser.nix
    # ./programs/ags/mod.nix
  ];


  programs = {
    btop.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    mpv.enable = true;
    starship.enable = true;
    foot.enable = true;
  };
  services.clipman.enable = true;
}
