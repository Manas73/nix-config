{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" "JetBrainsMono" ]; })
    powerline
    material-icons
    material-design-icons
  ];

  fonts.fontconfig.enable = true;
}