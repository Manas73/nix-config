{ pkgs, lib, config, system_settings, ... }: {

    options = {
        yazi.enable = lib.mkEnableOption "enables yazi";
    };

    config = lib.mkIf config.yazi.enable  {
        homebrew.casks = [ "yazi" ];
    };
}
