{ pkgs, lib, config, ... }:
{
  imports = [
    ./gtk.nix
    ./qt.nix
  ];
}