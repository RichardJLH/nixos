{ pkgs, lib, ... }:
let
  dracula-grub-theme = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "grub";
    rev = "0e721d99dbf0d5d6c4fd489b88248365b7a60d12";
    sha256 = "sha256-SBAXGJbNYdr89FSlqzgkiW/c23yTHYvNxxU8F1hMfXI=";
  };
in
{
  # Bootloader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;

        # despite what the configuration.nix manpage seems to indicate,
        # as of release 17.09, setting device to "nodev" will still call
        # `grub-install` if efiSupport is true
        # (the devices list is not used by the EFI grub install,
        # but must be set to some value in order to pass an assert in grub.nix)
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
		theme = "${dracula-grub-theme}/dracula";
      };
    };
  };
}
