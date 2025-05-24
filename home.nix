{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

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
	./programs/nh.nix
	./programs/nixvim.nix
    # ./programs/ags/mod.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
