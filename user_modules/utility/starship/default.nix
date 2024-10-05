{ pkgs, lib, config, user_settings, ... }: {

    options = {
        starship.enable = lib.mkEnableOption "enables starship";
    };

    config = lib.mkIf config.starship.enable  {
        home.packages = with pkgs; [ starship ];
    };
}
