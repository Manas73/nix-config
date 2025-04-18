{
  description = "NixOS Configuration";

  inputs = {
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

  };

  outputs = inputs @ {
    self,
    home-manager,
    sops-nix,
    darwin,
    nix-homebrew,
    ...
  } :

  let

    lib = inputs.nixpkgs.lib;
    mkFunctions = import ./mk-functions.nix { inherit inputs lib home-manager sops-nix darwin nix-homebrew; };
    
    # Import overlays
    overlays = import ./overlays;

    applications = {
      browsers = [ "vivaldi" "firefox" ];
      terminals = [ "kitty" ];
      default_browser = "vivaldi";
      utilities = [ "all" ];
      development_apps = [ "all" ];
      communications = [ "slack" "zoom" "rambox" ];
    };

    # Function to create package sets with our overlays
    mkPkgsWithOverlays = { system, allow_unfree_packages, permitted_insecure_package }: 
      import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = allow_unfree_packages;
          allowUnfreePredicate = (_: true);
          permittedInsecurePackages = permitted_insecure_package;
        };
        overlays = [
          overlays.additions
          overlays.modifications
          overlays.versions
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config = {
                allowUnfree = allow_unfree_packages;
                allowUnfreePredicate = (_: true);
              };
            };
          })
        ];
      };

    alfredConfig = {
      system_settings = mkFunctions.mkSystemSettings {
        system = "x86_64-linux";
        hostname = "alfred";
        timezone = "Asia/Kolkata";
        locale = "en_IN";
        gpu_type = "nvidia";
        shells = [ "fish" ];
        keyrings = [ "gnome-keyring" ];
        desktops = [ "i3plasma" ];
        allow_unfree_packages = true;
        permitted_insecure_package = [
          "openssl-1.1.1w"  # required by sublime
        ];
        mkPkgs = mkPkgsWithOverlays; # Use our new function with overlays
      };
      user_configurations = {
        "ms-nixos" = mkFunctions.mkUserSettings {
          username = "ms-nixos";
          full_name = "Manas Sambare";
          default_shell = "fish";
          office_suites = [ "libreoffice" ];
         } // applications;
      };
    };

    turingConfig = {
      system_settings = mkFunctions.mkDarwinSettings {
        system = "aarch64-darwin";
        hostname = "manass-KY4RYYHFF6";
        timezone = "Asia/Kolkata";
        locale = "en_IN";
        shells = [ "fish" ];
        allow_unfree_packages = true;
        permitted_insecure_package = [];
        mkPkgs = mkPkgsWithOverlays; # Use our new function with overlays
      } // applications;
      user_configurations = {
        "manas.s" = mkFunctions.mkUserSettings {
          username = "manas.s";
          full_name = "Manas Sambare";
          default_shell = "fish";
        };
      };
    };

    in {

      nixosConfigurations = {
        alfred = mkFunctions.mkNixosConfig {
          config = alfredConfig;
        };
      };

      darwinConfigurations = {
        "manass-KY4RYYHFF6" = mkFunctions.mkDarwinConfig {
          config = turingConfig;
        };
      };

      homeConfigurations = {
        "ms-nixos" = mkFunctions.mkHomeConfig {
          config = alfredConfig;
          username = "ms-nixos";
        };
        "manas.s" = mkFunctions.mkHomeConfig {
          config = turingConfig;
          username = "manas.s";
        };
      };

  };
}
