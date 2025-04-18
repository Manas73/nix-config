{ pkgs, lib, config, ... }: {

    options = {
        gnome-keyring.enable = lib.mkEnableOption "enables gnome-keyring";
    };

    config = lib.mkIf config.gnome-keyring.enable {
        services.gnome.gnome-keyring.enable = true;
    };
}