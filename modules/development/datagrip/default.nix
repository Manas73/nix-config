{ pkgs, lib, config, user_settings, ... }: {

    options = {
        datagrip.enable = lib.mkEnableOption "enables datagrip";
    };

    config = lib.mkIf config.datagrip.enable  {
        home.packages = with pkgs; [ jetbrains.datagrip ];
    };
}
