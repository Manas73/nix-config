{ pkgs, lib, config, user_settings, ... }: {

    options = {
        dropbox.enable = lib.mkEnableOption "enables dropbox";
    };

    config = lib.mkIf config.dropbox.enable  {
        services.dropbox.enable = true;
    };
}
