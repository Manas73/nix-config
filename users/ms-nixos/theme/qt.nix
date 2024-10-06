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
   };
}