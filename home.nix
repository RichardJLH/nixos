{ config, pkgs, ... }:

{
  imports = [
    ./programs/neovim/mod.nix
    ./programs/hyprland.nix
    ./programs/tmux.nix
    ./programs/starship.nix
    ./programs/nushell/mod.nix
    ./programs/kitty.nix
    ./programs/gammastep.nix
    ./programs/bat.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/ssh.nix
    ./programs/firefox.nix
    ./programs/btop.nix
    ./programs/lsd.nix
    ./programs/mpv.nix
    ./programs/clipman.nix
    ./programs/lazygit.nix
    ./programs/direnv.nix
	./programs/fzf.nix
    # ./programs/ags/mod.nix
  ];

  home = {
    username = "richard";
    homeDirectory = "/home/richard";
    stateVersion = "23.11";

	keyboard = {
      layout = "us";
      variant = "colemak";
	};

    packages = with pkgs; [
      keepassxc
      neofetch
      brightnessctl
      pavucontrol
      tor-browser
      socat
      plocate
      sbctl
	  chromium
	  clang-tools
	  gparted
	  unzip
	  cacert
      jetbrains.idea-community-bin
      (pkgs.nerd-fonts.jetbrains-mono)


      # unfree packages
      spotify
      whatsapp-for-linux
      steam-run
    ];
  };

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

# systemd.user.mounts = {
#   home-richard-leannas = {
#     Unit = {
#       Description = "Leannas cifs share mounted at boot";
#     };
#     Mount = {
  #       What = "//10.1.0.11/Transfer";
  #       Where = "/home/richard/leannas";
  #       Options = [ "credentials=/home/richard/leannas.credentials,rw,users,uid=1000,gid=1000" ];
  #       Type = "cifs";
  #       # TimeoutSec = 10;
  #     };
  #     Install = {
  #       WantedBy = [ "multi-user.target" ];
  #     };
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
