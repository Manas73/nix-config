# This file defines overlays
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev: import ./additions { pkgs = final; };

  # This one contains modifications to existing packages
  modifications = final: prev: import ./modifications { pkgs = final; };

  # Custom package versions or pins 
  versions = final: prev: import ./versions { pkgs = final; };
} 