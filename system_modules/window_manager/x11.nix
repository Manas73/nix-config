{ pkgs, ... }:

{
  imports = [
    ./commons.nix
  ];

  # Configure X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";

    desktopManager.xterm.enable = false;
  };

  services.displayManager.sddm.enable = true;

}