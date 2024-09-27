{ pkgs, lib, config, username, ... }: {

    options = {
        brave.enable = lib.mkEnableOption "enables brave";
    };

    config = lib.mkIf config.brave.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ brave ];
        };
    };
}
