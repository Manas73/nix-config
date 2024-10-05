{ pkgs, ... }:

{
  imports = [
    ../../keyring
    ./pipewire.nix
    ./dbus.nix
    ./fonts.nix
  ];
}