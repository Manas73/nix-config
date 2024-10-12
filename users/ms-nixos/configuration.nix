{ lib, config, inputs, pkgs, user_settings, ... }: {
    imports = [
    ../../system_modules
    ];

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };

    sops = {
        defaultSopsFile = ../../secrets.yaml;
        age = {
            keyFile = "/home/${user_settings.username}/.config/sops/age/keys.txt";
        };
        secrets = {
            "${user_settings.username}/password" = {
                neededForUsers = true;
            };

            "wireless.env" = { };
        };
    };
    networking.wireless.environmentFile = config.sops.secrets."wireless.env".path;
    networking.wireless.networks = {
        "@airtel_5g_uuid@" = {
          psk = "@airtel_5g_psk@";
        };
        "@airtel_uuid@" = {
          psk = "@airtel_psk@";
        };
        "@jio_5g_uuid@" = {
          psk = "@jio_5g_psk@";
        };
        "@jio_uuid@" = {
          psk = "@jio_psk@";
        };
        "@bang_bang_uuid@" = {
          psk = "@bang_bang_psk@";
        };
        "@bang_bang_5g_uuid@" = {
          psk = "@bang_bang_5g_psk@";
        };
        "@hotspot_uuid@" = {
          psk = "@hotspot_psk@";
        };
      };

    users.mutableUsers = false;   # Requried for password to be set via sops during system activation!
    users.users.${user_settings.username} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."${user_settings.username}/password".path;
      shell = pkgs.${user_settings.default_shell};
      description = user_settings.full_name;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

    users.users.root = {
      hashedPasswordFile = config.users.users.${user_settings.username}.hashedPasswordFile;
      password = lib.mkForce config.users.users.${user_settings.username}.password;
      openssh.authorizedKeys.keys = config.users.users.${user_settings.username}.openssh.authorizedKeys.keys;
    };

}