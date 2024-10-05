{ pkgs, lib, config, user_settings, ... }: {

    options = {
        zellij.enable = lib.mkEnableOption "enables zellij";
    };

    config = lib.mkIf config.zellij.enable  {
        home.packages = with pkgs; [ zellij ];
    };
}
