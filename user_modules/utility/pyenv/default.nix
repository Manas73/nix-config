{ pkgs, lib, config, ... }: {

    options = {
        pyenv.enable = lib.mkEnableOption "enables pyenv";
    };

    config = lib.mkIf config.pyenv.enable  {
        home.packages = with pkgs; [ pyenv ];
    };
}
