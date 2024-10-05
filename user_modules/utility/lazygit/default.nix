{ pkgs, lib, config, ... }: {

    options = {
        lazygit.enable = lib.mkEnableOption "enables lazygit";
    };

    config = lib.mkIf config.lazygit.enable  {
        home.packages = with pkgs; [ lazygit ];
    };
}
