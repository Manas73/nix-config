{ pkgs, lib, config, system_settings, ... }: {

    options = {
        stow.enable = lib.mkEnableOption "enables stow";
    };

    config = lib.mkIf config.stow.enable  {
        environment.systemPackages = [ pkgs.stow ];
    };
}
