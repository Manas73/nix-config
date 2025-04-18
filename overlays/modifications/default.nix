# Modify existing packages
{ pkgs }:

{
  # Example of overriding an existing package
  # vim = pkgs.vim.overrideAttrs (oldAttrs: {
  #   patches = (oldAttrs.patches or []) ++ [ ./path/to/patch.patch ];
  # });
} 