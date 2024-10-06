{ pkgs, lib, config, ... }: {

    options = {
        i3.enable = lib.mkEnableOption "enables i3";
    };

    config = lib.mkIf config.i3.enable {
        qt = {
          enable = true;
          platformTheme = "kde";
        };

        services.udisks2.enable = true;
        services.upower.enable = true;
        services.xserver.windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            kdePackages.dolphin
            # Themes
            kdePackages.breeze-gtk
            kdePackages.breeze-icons
            kdePackages.breeze.qt5
            kdePackages.breeze
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
    };
}