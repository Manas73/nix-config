{ pkgs, lib, config, username, ... }: {

    options = {
        kitty.enable = lib.mkEnableOption "enables kitty";
    };

    config = lib.mkIf config.kitty.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ kitty ];
        };
    };
}
