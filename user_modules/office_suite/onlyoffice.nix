{ pkgs, lib, config, user_settings, ... }: {

    options = {
        onlyoffice.enable = lib.mkEnableOption "enables onlyoffice";
    };

    config = lib.mkIf config.onlyoffice.enable  {
        home.packages = with pkgs; [ onlyoffice-bin_latest ];
    };
}
