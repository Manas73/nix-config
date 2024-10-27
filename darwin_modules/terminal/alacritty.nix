{ pkgs, lib, config, system_settings, ... }: {

    options = {
        alacritty.enable = lib.mkEnableOption "enables alacritty";
    };

    config = lib.mkIf config.alacritty.enable {
        homebrew.casks = [ "alacritty" ];
    };
}
