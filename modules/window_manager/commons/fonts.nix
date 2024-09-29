{ pkgs, username, ... }:

{
  home-manager.users.${username} = {pkgs, ... }: {
      home.packages = with pkgs; [
        nerdfonts
        powerline
        material-design-icons
      ];

      fonts.fontconfig.enable = true; 
  };

}