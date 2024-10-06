{ pkgs, lib, config, ... }: {

    options = {
        plasma6.enable = lib.mkEnableOption "enables plasma6";
    };

    config = lib.mkIf config.plasma6.enable  {
        services.desktopManager.plasma6.enable = true;
    };
}
