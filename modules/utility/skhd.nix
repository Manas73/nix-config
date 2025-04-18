{ pkgs, lib, config, user_settings, ... }: {

    options = {
        skhd.enable = lib.mkEnableOption "enables skhd";
    };

    config = lib.mkIf config.skhd.enable {
        # skhd is only available on macOS
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.skhd ];
        services.skhd.enable = lib.mkIf pkgs.stdenv.isDarwin true;
    };
}