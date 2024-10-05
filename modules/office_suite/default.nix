{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  office_suites_options = [ "onlyoffice" "libreoffice" ];
in
functions.makeModuleConfig {
  options = office_suites_options;
  current = user_settings.office_suites;
  module_name = "office_suite";
}
