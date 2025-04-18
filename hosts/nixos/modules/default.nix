{ pkgs, ... }:

let
  # Get all entries in the current directory
  entries = builtins.readDir ./.;

  # Filter out non-directories and create import paths
  moduleImports = builtins.map
    (name: ./${name})
    (builtins.filter
      (name: entries.${name} == "directory" && name != "default.nix")
      (builtins.attrNames entries));
in
{
  imports = moduleImports;

  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.dconf = {
    enable = true;
  };

  # Enables support for Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Enable Bluetooth support
  services.blueman.enable = true;

}
