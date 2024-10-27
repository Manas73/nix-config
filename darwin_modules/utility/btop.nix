{ pkgs, lib, config, system_settings, ... }: {

    options = {
        btop.enable = lib.mkEnableOption "enables btop";
    };

    config = lib.mkIf config.btop.enable  {
        homebrew.casks = [ "btop" ];
    };
}
