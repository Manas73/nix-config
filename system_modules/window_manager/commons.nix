{ pkgs, ... }:

{
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  fonts.packages = with pkgs; [
    nerdfonts
    powerline
    material-design-icons
  ];
    
  fonts.fontconfig.enable = true;

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

}