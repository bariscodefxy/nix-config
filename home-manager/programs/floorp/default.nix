{ pkgs, ... }:
{
  programs.floorp = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFormHistory = true;
      HardwareAcceleration = true;

      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        # Pywalfox
        "pywalfox@frewacom.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/pywalfox/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles = {
      "user" = {
        id = 0;
        isDefault = true;
        search = {
          force = true;
          default = "SearXNG";
          privateDefault = "SearXNG";
          engines = {
            "SearXNG" = {
              urls = [
                {
                  template = "http://localhost:3080/search?";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
            };
          };
        };
        settings = {
          "browser.startup.homepage" = "http://localhost:3080/";
          "browser.tabs.warnOnClose" = false;
          "general.useragent.locale" = "tr-TR";
        };
      };
    };
  };
}
