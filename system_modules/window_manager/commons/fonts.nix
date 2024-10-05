{ pkgs, user_settings, ... }:

{
  fonts.packages = with pkgs; [
    nerdfonts
    powerline
    material-design-icons
  ];

  fonts.fontconfig.enable = true;

}