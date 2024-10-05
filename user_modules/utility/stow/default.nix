{ pkgs, lib, config, user_settings, ... }: {

    options = {
        stow.enable = lib.mkEnableOption "enables stow";
    };

    config = lib.mkIf config.stow.enable  {
        home.packages = with pkgs; [ stow ];
    };
}
