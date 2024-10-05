{ pkgs, lib, config, user_settings, ... }: {

    options = {
        flameshot.enable = lib.mkEnableOption "enables flameshot";
    };

    config = lib.mkIf config.flameshot.enable  {
        home.packages = with pkgs; [ flameshot ];
    };
}
