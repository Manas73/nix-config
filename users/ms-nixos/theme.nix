{ pkgs, lib, config, ... }:
{
  # Cursor setup
  home.pointerCursor = {
    gtk.enable = true;
    name = "Capitaine Cursors";
    package = pkgs.capitaine-cursors;
    size = 16;
  };

  # GTK Setup
  gtk = {
    enable = true;
    theme = {
      name = "Sweet-mars";
      package = pkgs.sweet.override {
        colorVariants = [ "Sweet-mars" ];
      };
    };
    iconTheme = {
      name = "Tela-circle-manjaro-dark";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [ "manjaro" ];
      };
    };
    cursorTheme = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.kdePackages.breeze.qt5;
    };
  };

  dconf.settings."org/gtk/settings/file-chooser" = {
    sort-directories-first = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Sweet-mars";
      color-scheme = "prefer-dark";
    };
  };
}