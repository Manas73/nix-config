{ pkgs, lib, config, user_settings, ... }: {

    options = {
        psmisc.enable = lib.mkEnableOption "enables psmisc";
    };

    config = lib.mkIf config.psmisc.enable {
        # psmisc is only available on Linux
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ psmisc ]);
    };
}