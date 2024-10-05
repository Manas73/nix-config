{ pkgs, lib, config, user_settings, ... }: {

    options = {
        alacritty.enable = lib.mkEnableOption "enables alacritty";
    };

    config = lib.mkIf config.alacritty.enable {
        home.packages = with pkgs; [ alacritty ];
    };
}
