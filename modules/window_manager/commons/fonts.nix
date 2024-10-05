{ pkgs, user_settings, ... }:

{
  home.packages = with pkgs; [
    nerdfonts
    powerline
    material-design-icons
  ];

  fonts.fontconfig.enable = true;

}