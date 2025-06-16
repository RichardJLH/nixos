{pkgs, ...}: {
  home.packages = with pkgs; [sops age];
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      keyFile = "/home/user/.config/age/key.txt"; # must have no password!
    };
  };
}
