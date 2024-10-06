{ pkgs, ... }:
{
  # Configure X11
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";

    desktopManager.xterm.enable = false;
  };

  imports = [
    ./commons.nix
    ./sddm
  ];

}