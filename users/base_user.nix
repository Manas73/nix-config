{ pkgs, username, ... }: {

    imports = [
    ../modules
    ];

    home = {
     
      inherit username;
      homeDirectory = "/home/${username}";

      stateVersion = "24.05";
    
    };

    fonts.fontconfig.enable = true;
    
    programs.home-manager.enable = true;
    programs.git.enable = true;
    
    
    home.packages = [ pkgs.git-credential-manager ];

}
