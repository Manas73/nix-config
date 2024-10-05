{ pkgs, user_settings, ... }: {
    imports = [
    ../../system_modules
    ];

    users.users.ms-nixos = {
      isNormalUser = true;
      shell = pkgs.${user_settings.default_shell};
      description = user_settings.full_name;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

}