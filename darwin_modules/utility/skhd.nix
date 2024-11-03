{ pkgs, lib, config, ... }: {

    options = {
        skhd.enable = lib.mkEnableOption "enables skhd";
    };

    config = lib.mkIf config.skhd.enable  {
        environment.systemPackages = [ pkgs.skhd ];
        services.skhd.enable = true;
    };
}
