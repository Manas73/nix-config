{ pkgs, lib, config, username, ... }: {

    options = {
        onlyoffice.enable = lib.mkEnableOption "enables onlyoffice";
    };

    config = lib.mkIf config.onlyoffice.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ onlyoffice-bin_latest ];
        };
    };
}
