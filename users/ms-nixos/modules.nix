{ pkgs, ... }: {

  imports = [
    ../../modules/browser
    ../../modules/keyring
    ../../modules/terminal
    ../../modules/utility
    ../../modules/window_manager
  ];

}
