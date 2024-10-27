{ pkgs, lib, config, ... }: {

    options = {
        pyenv.enable = lib.mkEnableOption "enables pyenv";
    };

    config = lib.mkIf config.pyenv.enable  {
        homebrew.casks = [ "pyenv" "pyenv-virtualenv" ];
    };
}
