{ pkgs, lib, config, ... }: {

    options = {
        greenclip.enable = lib.mkEnableOption "enables greenclip";
    };

    config = lib.mkIf config.greenclip.enable {
        # Greenclip is only available on Linux
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ haskellPackages.greenclip ]);
    };
}