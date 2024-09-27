{ pkgs, lib, config, username, ... }: {

    options = {
        btop.enable = lib.mkEnableOption "enables btop";
    };

    config = lib.mkIf config.btop.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ btop ];
        };
    };
}
