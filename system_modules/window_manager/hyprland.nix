{ pkgs, lib, config, ... }: {

    imports = [
      ./sddm
    ];

    options = {
        hyprland.enable = lib.mkEnableOption "enables hyprland";
    };

    config = lib.mkIf config.i3.enable {
      # Call dbus-update-activation-environment on login
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      services.xserver.updateDbusEnvironment = true;

      # Enable Hyprland
      programs.hyprland = {
        enable = true;
      };

      # Enable Ozone Wayland support in Chromium and Electron based applications
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        XCURSOR_SIZE = "24";
        LIBVA_DRIVER_NAME = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        ELECTRON_OZONE_PLATFORM_HINT="auto";
        WLR_NO_HARDWARE_CURSORS = "1";
      };

      # List of Hyprland specific packages
      environment.systemPackages = with pkgs; [
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

        brightnessctl
        grim
        hypridle
        hyprlock
        hyprpaper
        hyprpicker
        libnotify
        networkmanagerapplet
        pamixer
        slurp
        wf-recorder
        wlr-randr
        wlsunset
      ];
    };
}