{ pkgs, lib, config, system_settings, ... }: {

    options = {
        gitkraken.enable = lib.mkEnableOption "enables gitkraken";
    };

    config = lib.mkIf config.gitkraken.enable  {
        homebrew.casks = [ "gitkraken" ];
    };
}
