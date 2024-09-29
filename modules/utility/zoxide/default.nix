{ pkgs, lib, config, username, ... }: {

    options = {
        zoxide.enable = lib.mkEnableOption "enables zoxide";
    };

    config = lib.mkIf config.zoxide.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ zoxide ];
        };
    };
}
