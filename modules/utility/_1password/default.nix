{ pkgs, lib, config, username, ... }: {

    options = {
        _1password.enable = lib.mkEnableOption "enables 1password";
    };

    config = lib.mkIf config._1password.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ _1password _1password-gui ];
        };
    };
}
