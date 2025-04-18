{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" "JetBrainsMono" ]; })
    powerline
    roboto
    material-icons
    material-design-icons
  ];

}