{ ... }:
{
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DNSOverHTTPS = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DontCheckDefaultBrowser = false;
      DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "never"
      Homepage.StartPage = "previous-session";
      SearchBar = "unified"; # alternative: "separate"
      SearchSuggestEnabled = true;
      # about:support to get ids
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        # Simple Tab Groups
        "simple-tab-groups@drive4ik" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-tab-groups/latest.xpi";
        };
        # Google Keyboard shortcuts
        "{c7812b2a-ab08-475a-806d-326718a58747}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/google-search-result-shortcuts/latest.xpi";
        };
        # Enhancer for YouTube
        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/latest.xpi";
        };
        # BetterTTV
        "firefox@betterttv.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/betterttv/latest.xpi";
        };
      };
    };
  };

}
