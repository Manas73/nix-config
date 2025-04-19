{ pkgs, lib, config, ... }: {

    options = {
        plasma.enable = lib.mkEnableOption "enables plasma";
    };

    config = lib.mkIf config.plasma.enable  {
        # Enable the KDE Plasma Desktop Environment.
        services.xserver.desktopManager.plasma5.enable = true;
    };

}
