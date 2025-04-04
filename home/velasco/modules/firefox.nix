{ pkgs, ... }:
{
  # Check about:policies
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://doh.libredns.gr/noads";
        Locked = true;
        Fallback = true;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DontCheckDefaultBrowser = false;
      DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "never"
      Homepage.StartPage = "previous-session";
      HttpsOOnlyMode = true;
      OfferToSaveLogins = false;
      Preferences = {
        "privacy.clearOnShutdown.history" = false;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        "webgl.disabled" = false;
      };
      RequestedLocales = "en-US,pt-BR,fr";
      SearchBar = "unified"; # alternative: "separate"
      SearchEngines = { Default = "DuckDuckGo"; Remove = [ "Google" "Bing" ]; PreventInstalls = true; };
      SearchSuggestEnabled = true;
      # about:support to get ids
      ExtensionSettings = {
        "*".installation_mode = "blocked";
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
        # Simple Tab Groups
        "simple-tab-groups@drive4ik" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-tab-groups/latest.xpi";
        };
        # BetterTTV
        "firefox@betterttv.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/betterttv/latest.xpi";
        };
        # Canvas Blocker
        "CanvasBlocker@kkapsner.de" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4413485/canvasblocker-1.11.xpi";
        };
      };
    };
  };

}
