{
  description = "NixOS Configuration";

  inputs = {
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager-unstable.url = "github:nix-community/home-manager/master";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs @ {
    self,
    home-manager,
    sops-nix,
    darwin,
    ...
  } :

  let
    lib = inputs.nixpkgs.lib;

    # Define a function to create pkgs and pkgs-unstable
    mkPkgs = { system, allow_unfree_packages, permitted_insecure_package }: {

      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = allow_unfree_packages;
          allowUnfreePredicate = (_: true);
          permittedInsecurePackages = permitted_insecure_package;
        };
      };

      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = allow_unfree_packages;
          allowUnfreePredicate = (_: true);
        };
      };

    };

    mkSystemSettings = {
      system,
      hostname,
      timezone,
      locale,
      gpu_type ? null,
      allow_unfree_packages ? false,
      keyrings ? [ ],
      permitted_insecure_package ? [ ],
      shells ? [ ],
      desktop_managers ? [ ],
      window_managers ?  [ ]
    }: let
      package_config = mkPkgs {
        inherit system allow_unfree_packages permitted_insecure_package;
      };
    in {
      inherit system hostname timezone locale gpu_type keyrings shells desktop_managers window_managers;
      pkgs = package_config.pkgs;
      pkgs-unstable = package_config.pkgs-unstable;
    };

    mkUserSettings = {
      username,
      full_name,
      default_shell,
      default_browser,
      terminals ? [ ],
      browsers ? [ ],
      utilities ? [ ],
      development_apps ? [ ],
      communications ? [ ],
      office_suites ? [ ]
    }: {
      inherit username full_name default_shell terminals browsers default_browser utilities development_apps communications office_suites;
    };

    alfredConfig = {
      system_settings = mkSystemSettings {
        system = "x86_64-linux";
        hostname = "alfred";
        timezone = "Asia/Kolkata";
        locale = "en_IN";
        gpu_type = "nvidia";
        shells = [ "fish" ];
        keyrings = [ "gnome-keyring" ];
        window_managers = [ "i3" ];
        allow_unfree_packages = true;
        permitted_insecure_package = [
          "openssl-1.1.1w"  # required by sublime
        ];
      };
      user_configurations = {
        "ms-nixos" = mkUserSettings {
          username = "ms-nixos";
          full_name = "Manas Sambare";
          default_shell = "fish";
          browsers = [ "vivaldi" "firefox" ];
          terminals = [ "kitty" ];
          default_browser = "vivaldi";
          utilities = [ "all" ];
          development_apps = [ "all" ];
          communications = [ "slack" "zoom" "rambox" ];
          office_suites = [ "libreoffice" ];
         };
      };
    };

    # Helper function to create home-manager configurations
    mkHomeConfig = { config, username }:
      let
        systemSettings = config.system_settings;
        userSettings = config.user_configurations.${username};
      in
      home-manager.lib.homeManagerConfiguration {
        pkgs = systemSettings.pkgs;
        modules = [ ./users/${username}/home.nix ];
        extraSpecialArgs = {
          pkgs = systemSettings.pkgs;
          pkgs-unstable = systemSettings.pkgs-unstable;
          system_settings = systemSettings;
          user_settings = userSettings;
          inherit inputs;
        };
      };

    # Helper function to create NixOS configurations
    mkNixosConfig = { config }:
      let
        systemSettings = config.system_settings;
        userConfigurations = config.user_configurations;
      in
      lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          ./hosts/${systemSettings.hostname}
          sops-nix.nixosModules.sops
        ] ++ (map (username: ./users/${username}/configuration.nix) (builtins.attrNames userConfigurations));
        specialArgs = {
          pkgs = systemSettings.pkgs;
          pkgs-unstable = systemSettings.pkgs-unstable;
          system_settings = systemSettings;
          user_configurations = userConfigurations;
          inherit inputs;
        };
      };


    in {
      homeConfigurations = {
        "ms-nixos" = mkHomeConfig {
          config = alfredConfig;
          username = "ms-nixos";
        };
      };

      nixosConfigurations = {
        alfred = mkNixosConfig {
          config = alfredConfig;
        };
      };
  };
}
