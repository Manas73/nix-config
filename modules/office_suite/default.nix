{ pkgs, lib, system_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  office_suites_options = [ "libreoffice" "onlyoffice" ];
in
functions.makeModuleConfig {
  options = office_suites_options;
  current = system_settings.office_suites;
  module_name = "office_suite";
}