{ pkgs, lib, config, user_settings, ... }: {

    options = {
        flameshot.enable = lib.mkEnableOption "enables flameshot";
    };

    config = lib.mkIf config.flameshot.enable {
        # Flameshot is only available on Linux
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ flameshot ]);
    };
}