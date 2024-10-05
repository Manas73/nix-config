{
  description = "NixOS Configuration";

  inputs = {
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager-unstable.url = "github:nix-community/home-manager/master";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

  };

  outputs = inputs @ {
    self,
    home-manager,
    ...
  } :

  let
    system_settings = {
        system = "x86_64-linux";
        hostname = "alfred";
        timezone = "Asia/Kolkata";
        locale = "en_IN";
        gpu_type = "nvidia";
    };

    user_settings = {
        username = "ms-nixos";
        full_name = "Manas Sambare";
        terminals = [ "kitty" ];
        keyring = "gnome-keyring";
        window_manager = "i3";
        browsers = [ "vivaldi" "firefox" ];
        default_browser = "vivaldi";
        utilities = [ "all" ];
        development_apps = [ "all" ];
        communications = [ "slack" "zoom" "rambox" ];
        office_suites = [ "libreoffice" ];
    };

    pkgs = import inputs.nixpkgs {
       system = system_settings.system;
       config = {
         allowUnfree = true;
         allowUnfreePredicate = (_: true);
       };
     };

    lib = inputs.nixpkgs.lib;

    pkgs-unstable = import inputs.nixpkgs-unstable {
        system = system_settings.system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
    };

    in {
       homeConfigurations = {
         user = home-manager.lib.homeManagerConfiguration {
           inherit pkgs;
           modules = [
             ./users/${user_settings.username}/home.nix
             ./users/${user_settings.username}/modules.nix
           ];
           extraSpecialArgs = {
             # pass config variables from above
             inherit pkgs;
             inherit pkgs-unstable;
             inherit system_settings;
             inherit user_settings;
             inherit inputs;
           };
         };
       };

      nixosConfigurations = {
        system = lib.nixosSystem {
          inherit pkgs;
          system = system_settings.system;
          modules = [
            ./hosts/alfred
          ];
          specialArgs = {
            # pass config variables from above
            inherit pkgs;
            inherit pkgs-unstable;
            inherit system_settings;
            inherit user_settings;
            inherit inputs;
          };
        };
      };
  };
}
