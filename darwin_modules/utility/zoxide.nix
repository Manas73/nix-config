{ pkgs, lib, config, system_settings, ... }: {

    options = {
        zoxide.enable = lib.mkEnableOption "enables zoxide";
    };

    config = lib.mkIf config.zoxide.enable  {
        environment.systemPackages = [ pkgs.zoxide ];
    };
}
