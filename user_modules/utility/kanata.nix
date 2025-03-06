{ pkgs, lib, config, ... }: {

    options = {
        kanata.enable = lib.mkEnableOption "enables kanata";
    };

    config = lib.mkIf config.kanata.enable  {
        home.packages = with pkgs; [ kanata ];
    };
}
