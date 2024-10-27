{ pkgs, lib, config, system_settings, ... }: {

    options = {
        kitty.enable = lib.mkEnableOption "enables kitty";
    };

    config = lib.mkIf config.kitty.enable  {
        homebrew.casks = [ "kitty" ];
    };
}
