{ pkgs, user_settings, ... }: {
    imports = [
    ../../system_modules
    ];

    sops.secrets.ms-nixos-password.neededForUsers = true;
    users.mutableUsers = false;   # Requried for password to be set via sops during system activation!

    users.users.ms-nixos = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.ms-nixos-password.path;
      shell = pkgs.${user_settings.default_shell};
      description = user_settings.full_name;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

}