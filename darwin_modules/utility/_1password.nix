{ pkgs, lib, config, system_settings, ... }: {

    options = {
        _1password.enable = lib.mkEnableOption "enables 1password";
    };

    config = lib.mkIf config._1password.enable  {
        homebrew.casks = [ "1password" ];
    };
}
