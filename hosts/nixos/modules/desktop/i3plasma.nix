{ pkgs, lib, config, ... }: {

    options = {
        i3plasma.enable = lib.mkEnableOption "enables i3plasma";
    };

    config = lib.mkIf config.i3plasma.enable  {
        plasma6.enable = true;
        i3.enable = true;

        services.xserver.displayManager = {
            defaultSession = "i3+plasma";
            session = [
                {
                    manage = "desktop";
                    name = "i3+plasma";
                    start = ''exec env KDEWM=${pkgs.i3-gaps}/bin/i3 ${pkgs.plasma-workspace}/bin/startplasma-x11'';
                }
            ];
        };
    };
}
