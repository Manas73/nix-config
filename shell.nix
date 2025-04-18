# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nix-config-dev";
  buildInputs = with pkgs; [
    # Basic dependencies
    git
    gnumake
    
    # Nix tools
    nixpkgs-fmt  # Formatter for Nix code
    statix       # Lints and suggestions for Nix code
    
    # For secrets management
    sops
    ssh-to-age
    
    # Documentation
    nixdoc
  ];
  
  shellHook = ''
    echo "Welcome to the nix-config development environment!"
    echo "Available commands:"
    echo "  nixpkgs-fmt <file>   - Format Nix files"
    echo "  statix check         - Check for common Nix anti-patterns"
    echo "  statix fix           - Fix common Nix anti-patterns"
    echo ""
  '';
} 