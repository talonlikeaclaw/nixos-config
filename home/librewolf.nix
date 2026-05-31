{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    languagePacks = [ "en-US" ];

    settings = {
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
      "privacy.clearOnShutdown.cache" = false;
      "network.cookie.lifetimePolicy" = 0;
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;

      "extensions.pocket.enabled" = false;
      "identity.fxaccounts.enabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "dom.push.enabled" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.uitour.enabled" = false;
      "browser.ping-centre.telemetry" = false;

      "gfx.webrender.all" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "image.jxl.enabled" = true;

      "sidebar.expandOnHover" = true;
    };

    policies =
      let
        moz = slug: "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
      in
      {
        SearchEngines = {
          Default = "Startpage";
          Private = "Startpage";
          Remove = [
            "Bing"
            "Amazon.com"
            "eBay"
          ];
        };

        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
            default_area = "navbar";
            private_browsing = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = moz "bitwarden-password-manager";
            installation_mode = "force_installed";
            default_area = "navbar";
            private_browsing = true;
          };
          "vimium@philc.io" = {
            install_url = moz "vimium-ff";
            installation_mode = "force_installed";
            default_area = "navbar";
          };
          "addon@darkreader.org" = {
            install_url = moz "darkreader";
            installation_mode = "force_installed";
            default_area = "navbar";
          };
        };
      };

    profiles.default = {
      id = 0;
      isDefault = true;
      name = "default";

      settings = {
        "extensions.autoDisableScopes" = 0;
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.search.defaultenginename" = "Startpage";
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.separatePrivateDefault" = "Startpage";
        "browser.toolbars.bookmarks.visibility" = "newtab";
      };

      search = {
        force = true;

        engines = {
          "bing".metaData.hidden = true;
          "amazondotcom-us".metaData.hidden = true;
          "ebay".metaData.hidden = true;

          "qwant".definedAliases = [ "@qw" ];
          "ddg".definedAliases = [ "@ddg" ];
          "wikipedia".definedAliases = [ "@wiki" ];
          "google".definedAliases = [ "@g" ];

          "Startpage" = {
            definedAliases = [ "@st" ];
            urls = [
              {
                template = "https://www.startpage.com/sp/search";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "GitHub" = {
            definedAliases = [ "@gh" ];
            urls = [
              {
                template = "https://github.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "DevDocs" = {
            definedAliases = [ "@dev" ];
            urls = [
              {
                template = "https://devdocs.io/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "NixOS Options" = {
            definedAliases = [ "@no" ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Brave" = {
            definedAliases = [ "@br" ];
            urls = [
              {
                template = "https://search.brave.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
          };

          "Perplexity" = {
            definedAliases = [ "@px" ];
            urls = [
              {
                template = "https://www.perplexity.ai/search";
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

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Bookmarks Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "Proton Mail";
                url = "https://mail.proton.me";
              }
              {
                name = "Homelab";
                url = "https://homepage.talonlikeaclaw.com";
              }
              {
                name = "GitHub";
                url = "https://github.com";
              }
              {
                name = "OpenCode";
                url = "https://opencode.ai/go";
              }
              {
                name = "Monkeytype";
                url = "https://monkeytype.com";
              }
            ];
          }
        ];
      };
    };
  };
}
