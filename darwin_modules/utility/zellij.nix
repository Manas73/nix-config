{ pkgs, lib, config, system_settings, ... }: {

    options = {
        zellij.enable = lib.mkEnableOption "enables zellij";
    };

    config = lib.mkIf config.zellij.enable  {
        homebrew.casks = [ "zellij" ];
    };
}
