{ pkgs, lib, config, ... }: {

    options = {
        yabai.enable = lib.mkEnableOption "enables yabai";
    };

    config = lib.mkIf config.yabai.enable {
        # yabai is only available on macOS
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.yabai pkgs.jankyborders ];

        services.yabai.enable = lib.mkIf pkgs.stdenv.isDarwin true;
    };
}