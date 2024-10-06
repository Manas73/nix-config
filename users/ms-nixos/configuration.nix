{ pkgs, user_settings, ... }: {
    imports = [
    ../../system_modules
    ];

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };

    users.users.ms-nixos = {
      isNormalUser = true;
      shell = pkgs.${user_settings.default_shell};
      description = user_settings.full_name;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

}