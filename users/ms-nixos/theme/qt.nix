{ pkgs, lib, config, ... }:
let
 sweet-mars-kvantum = import ./sweet-mars-kvantum.nix { inherit pkgs; };
 in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };


  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
        General.theme = "Sweet-Mars";
    };
    "Kvantum/Sweet-Mars".source = "${sweet-mars-kvantum}/share/Kvantum/Sweet-Mars";

    "qt6ct/qt6ct.conf".source = (pkgs.formats.ini { }).generate "qt6ct.conf" {
     
         Appearance.icon_theme = "Tela-circle-manjaro";
         Appearance.style = "kvantum-dark";

         Fonts.fixed="JetBrainsMono Nerd Font,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
         Fonts.general="Roboto,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular";
         
    };
 };
}
