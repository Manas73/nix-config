{ pkgs, ... }: {

  imports = [
    ../../modules/browser
    ../../modules/keyring
    ../../modules/terminal
    ../../modules/window_manager
  ];

}
