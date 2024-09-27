{ pkgs, lib, username, browsers, default_browser, ... }:

let
  functions = import ../functions.nix { inherit pkgs lib; };
  browser_options = [ "vivaldi" "firefox" "brave"];

  browserConfig = _: {
    home-manager.users."${username}".xdg.mimeApps = {
      defaultApplications = {
        "text/html" = "${default_browser}.desktop";
        "x-scheme-handler/http" = "${default_browser}.desktop";
        "x-scheme-handler/https" = "${default_browser}.desktop";
        "x-scheme-handler/about" = "${default_browser}.desktop";
        "x-scheme-handler/unknown" = "${default_browser}.desktop";
      };
    };
  };

in
  functions.makeModuleConfig {
    options = browser_options;
    current = browsers;
    module_name = "browser";
    extraConfig = browserConfig;
  }