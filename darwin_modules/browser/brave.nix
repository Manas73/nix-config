{ pkgs, lib, config, ... }: {

    options = {
        brave.enable = lib.mkEnableOption "enables brave";
    };

    config = lib.mkIf config.brave.enable  {
        homebrew.casks = [ "brave-browser" ];
    };
}
