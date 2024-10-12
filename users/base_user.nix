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
}
