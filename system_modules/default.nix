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

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata.enable = true;

}