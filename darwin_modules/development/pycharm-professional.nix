{ pkgs, lib, config, system_settings, ... }: {

    options = {
        pycharm-professional.enable = lib.mkEnableOption "enables pycharm-professional";
    };

    config = lib.mkIf config.pycharm-professional.enable  {
        homebrew.casks = [ "pycharm" ];
    };
}
