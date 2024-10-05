{ pkgs, lib, config, ... }: {

    options = {
        psmisc.enable = lib.mkEnableOption "enables psmisc";
    };

    config = lib.mkIf config.psmisc.enable  {
        home.packages = with pkgs; [ psmisc ];
    };
}
