{ pkgs-unstable, lib, config, system_settings, ... }: {

    options = {
        rambox.enable = lib.mkEnableOption "enables rambox";
    };

    config = lib.mkIf config.rambox.enable  {
        homebrew.casks = [ "rambox" ];
    };
}
