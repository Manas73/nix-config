{ pkgs, lib, config, ... }: {

    options = {
        i3.enable = lib.mkEnableOption "enables i3";
    };

    config = lib.mkIf config.i3.enable {
        imports = [
            ./sddm
        ];

        # Configure X11
        services.xserver = {
            enable = true;
            xkb.layout = "us";
            xkb.variant = "";

            desktopManager.xterm.enable = false;
        };


        services.udisks2.enable = true;
        services.upower.enable = true;
        services.xserver.windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            dunst
            kdePackages.dolphin
            # Themes
            libsForQt5.qtstyleplugin-kvantum
            kdePackages.breeze-gtk
            kdePackages.breeze-icons
            kdePackages.breeze.qt5
            kdePackages.breeze
            kdePackages.qtsvg
            kdePackages.kio-fuse # to mount remote filesystems via FUSE
            kdePackages.kio-extras # extra protocols support (sftp, fish and more)
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
