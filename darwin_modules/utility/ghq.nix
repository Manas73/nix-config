{ pkgs, lib, config, system_settings, ... }: {

    options = {
        ghq.enable = lib.mkEnableOption "enables ghq";
    };

    config = lib.mkIf config.ghq.enable  {
        environment.systemPackages = [ pkgs.ghq ];
    };
}
