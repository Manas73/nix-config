{ pkgs, lib, office_suitess, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  office_suites_options = [ "onlyoffice" "libreoffice" ];
in
functions.makeModuleConfig {
  options = office_suites_options;
  current = office_suitess;
  module_name = "office_suites";
}
