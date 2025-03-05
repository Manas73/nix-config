{ lib, config, inputs, pkgs, user_configurations, ... }:

let
  user_settings = user_configurations."ms-nixos";
in

{
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


    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      };
    };
}
