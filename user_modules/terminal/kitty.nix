{ pkgs, lib, config, user_settings, ... }: {

    options = {
        kitty.enable = lib.mkEnableOption "enables kitty";
    };

    config = lib.mkIf config.kitty.enable  {
        home.packages = with pkgs; [ kitty ];
    };
}
