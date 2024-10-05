{ pkgs-unstable, lib, config, user_settings, ... }: {

    options = {
        rambox.enable = lib.mkEnableOption "enables rambox";
    };

    config = lib.mkIf config.rambox.enable  {
        home.packages = with pkgs-unstable; [ rambox ];
    };
}
