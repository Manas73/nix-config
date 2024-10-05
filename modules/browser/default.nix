{ pkgs, lib, user_settings, ... }:

let
  functions = import ../functions.nix { inherit pkgs lib; };
  browser_options = [ "vivaldi" "firefox" "brave"];

  browserConfig = _: {
    xdg.mimeApps.defaultApplications = {
        "text/html" = "${user_settings.default_browser}.desktop";
        "x-scheme-handler/http" = "${user_settings.default_browser}.desktop";
        "x-scheme-handler/https" = "${user_settings.default_browser}.desktop";
        "x-scheme-handler/about" = "${user_settings.default_browser}.desktop";
        "x-scheme-handler/unknown" = "${user_settings.default_browser}.desktop";
    };
  };

in
  functions.makeModuleConfig {
    options = browser_options;
    current = user_settings.browsers;
    module_name = "browser";
    extraConfig = browserConfig;
  }