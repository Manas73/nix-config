{ pkgs, lib, config, ... }: {

    options = {
        sketchybar.enable = lib.mkEnableOption "enables sketchybar";
    };

    config = lib.mkIf config.sketchybar.enable {
        # Sketchybar is only available on macOS
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "sf-symbols" ];
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.jq pkgs.gh pkgs.sketchybar-app-font ];

        services.sketchybar = lib.mkIf pkgs.stdenv.isDarwin {
            enable = true;
            package = pkgs.sketchybar;
        };

        system.defaults.NSGlobalDomain._HIHideMenuBar = lib.mkIf pkgs.stdenv.isDarwin true;
    };
}