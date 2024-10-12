{ lib, config, inputs, pkgs, user_settings, ... }: {
    imports = [
    ../../system_modules
    inputs.sops-nix.nixosModules.sops
    ];

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };

    sops.age.keyFile = "/home/${user_settings.username}/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ../../secrets.yaml;
    sops.validateSopsFiles = true;
    sops.secrets."${user_settings.username}/password".neededForUsers = true;

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