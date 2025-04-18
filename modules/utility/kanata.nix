{ pkgs, lib, config, ... }: {

    options = {
        kanata.enable = lib.mkEnableOption "enables kanata";
    };

    config = lib.mkIf config.kanata.enable {
        # Kanata is only available on Linux
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ kanata ]);
    };
}