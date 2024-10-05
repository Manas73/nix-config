{ pkgs, user_settings, ... }: {

    home = {
      username = user_settings.username;
      homeDirectory = "/home/${user_settings.username}";

      stateVersion = "24.05";
    
    };

    fonts.fontconfig.enable = true;
    
    programs.home-manager.enable = true;
    programs.git.enable = true;

    xdg.enable = true;
    home.packages = [ pkgs.git-credential-manager ];

}
