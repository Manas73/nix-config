{ pkgs, lib, config, ... }: {

    options = {
        yabai.enable = lib.mkEnableOption "enables yabai";
    };

    config = lib.mkIf config.yabai.enable  {
        environment.systemPackages = [ pkgs.yabai pkgs.jankyborders ];

        services.yabai.enable = true;
    };
}
