{ inputs, ... }:
{
  flake.modules.homeManager.zen-browser = {
    imports = [
      inputs.zen-browser.homeModules.twilight
    ];

    programs.zen-browser = {
      enable = true;
      # setAsDefaultBrowser = true;

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        ExtensionSettings = {
          force = true;
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            default_area = "navbar";
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            default_area = "navbar";
          };
          # Dark Reader
          "addon@darkreader.org" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            default_area = "navbar";
          };
          # I Still Don't care about Cookies
          "idcac-pub@guus.ninja" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
            default_area = "navbar";
          };
        };
      };
    };
  };
}
