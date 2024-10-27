{ pkgs, lib, config, ... }: {

    options = {
        eza.enable = lib.mkEnableOption "enables eza";
    };

    config = lib.mkIf config.eza.enable  {
        homebrew.casks = [ "eza" ];
    };
}
