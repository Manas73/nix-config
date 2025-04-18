{ pkgs, lib, config, ... }: {

    options = {
        plasma6.enable = lib.mkEnableOption "enables plasma6";
    };

    config = lib.mkIf config.plasma6.enable  {
        # Enable the KDE Plasma Desktop Environment.
        services.desktopManager.plasma6.enable = true;
    };

}
