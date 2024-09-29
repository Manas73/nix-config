{ pkgs, lib, config, username, ... }: {

    options = {
        zellij.enable = lib.mkEnableOption "enables zellij";
    };

    config = lib.mkIf config.zellij.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ zellij ];
        };
    };
}
