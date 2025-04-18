{ pkgs, lib, config, ... }: {

    options = {
        i3plasma.enable = lib.mkEnableOption "enables i3plasma";
    };

    config = lib.mkIf config.i3plasma.enable  {
        imports = [
        ../../login_manager/sddm
        ];

        services.xserver.enable = true;
        services.desktopManager.plasma6.enable = true;

        services.xserver.windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            libsForQt5.qtstyleplugin-kvantum
           (
                rofi.override (old: {
                    plugins = [rofi-emoji rofi-calc];
                })
            )
            i3-gaps
            picom-next
            xcompmgr
            feh
            (
                polybar.override {
                    i3Support = true;
                }
            )
            xbindkeys
            xorg.xdpyinfo
            sysstat
            yad
          ];
        };

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
