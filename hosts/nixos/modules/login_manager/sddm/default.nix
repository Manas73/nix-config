{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ./themes/chilli.nix {inherit pkgs; }}";
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];
}