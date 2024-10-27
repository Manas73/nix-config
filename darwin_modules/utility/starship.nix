{ pkgs, lib, config, system_settings, ... }: {

    options = {
        starship.enable = lib.mkEnableOption "enables starship";
    };

    config = lib.mkIf config.starship.enable  {
        homebrew.casks = [ "starship" ];
    };
}
