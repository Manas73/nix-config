{ pkgs, lib, config, user_settings, ... }: {

    options = {
        gparted.enable = lib.mkEnableOption "enables gparted";
    };

    config = lib.mkIf config.gparted.enable {
        # Gparted is only available on Linux
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ gparted ]);
    };
}