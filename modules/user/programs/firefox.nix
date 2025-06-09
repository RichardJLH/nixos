{
  pkgs,
  firefox-addons,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://google.com";
          "browser.search.defaultenginename" = "Google";
          "services.sync.prefs.sync.extensions.activeThemeID" = false;
        };
        extensions.packages = with firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          darkreader
          passff
        ];
      };
    };
    nativeMessagingHosts = [pkgs.passff-host];
  };
}
