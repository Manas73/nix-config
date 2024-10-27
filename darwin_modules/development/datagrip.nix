{ pkgs, lib, config, system_settings, ... }: {

    options = {
        datagrip.enable = lib.mkEnableOption "enables datagrip";
    };

    config = lib.mkIf config.datagrip.enable  {
        homebrew.casks = [ "datagrip" ];
    };
}
