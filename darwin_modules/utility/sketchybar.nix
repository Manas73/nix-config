{ pkgs, lib, config, ... }: {

    options = {
        sketchybar.enable = lib.mkEnableOption "enables sketchybar";
    };

    config = lib.mkIf config.sketchybar.enable  {
        homebrew.casks = [ "sf-symbols" ];
        environment.systemPackages = [ pkgs.jq pkgs.gh pkgs.sketchybar-app-font ];

        services.sketchybar = {
            enable = true;
            package = pkgs.sketchybar;
          };

        system.defaults.NSGlobalDomain._HIHideMenuBar = true;
    };
}
