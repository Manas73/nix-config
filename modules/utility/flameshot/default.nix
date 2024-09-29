{ pkgs, lib, config, username, ... }: {

    options = {
        flameshot.enable = lib.mkEnableOption "enables flameshot";
    };

    config = lib.mkIf config.flameshot.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ flameshot ];
        };
    };
}
