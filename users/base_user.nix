{ inputs, pkgs, config, user_settings, ... }: {

    home = {
      username = user_settings.username;
      homeDirectory = "/home/${user_settings.username}";

      stateVersion = "24.05";

    };

    fonts.fontconfig.enable = true;
    
    programs.home-manager.enable = true;
    programs.git.enable = true;
    programs.git.package = pkgs.gitFull;
    programs.git.extraConfig.credential.helper = "store";

    xdg.enable = true;
    home.packages = with pkgs; [
        git-credential-manager
        age
    ];

    
    xdg.mimeApps.defaultApplications =
    if (user_settings.default_browser != "" && builtins.elem user_settings.default_browser user_settings.browsers)
    then {
      "text/html" = "${user_settings.default_browser}.desktop";
      "x-scheme-handler/http" = "${user_settings.default_browser}.desktop";
      "x-scheme-handler/https" = "${user_settings.default_browser}.desktop";
      "x-scheme-handler/about" = "${user_settings.default_browser}.desktop";
      "x-scheme-handler/unknown" = "${user_settings.default_browser}.desktop";
    }
    else {};
}
