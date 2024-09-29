{ pkgs, lib, config, ... }: {

    options = {
        i3.enable = lib.mkEnableOption "enables i3";
    };

    config = lib.mkIf config.i3.enable {
        services.xserver.windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            kdePackages.dolphin
            rofi
            i3-gaps
            picom-next
            xcompmgr
            feh
            polybar
            xbindkeys
            xorg.xdpyinfo
            sysstat
          ];
        };
    };
}