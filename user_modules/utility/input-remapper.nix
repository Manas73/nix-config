{ pkgs, lib, config, ... }: {

    options = {
        input-remapper.enable = lib.mkEnableOption "enables input-remapper";
    };

    config = lib.mkIf config.input-remapper.enable  {
        home.packages = with pkgs; [ input-remapper ];
    };
}
