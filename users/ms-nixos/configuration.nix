{ pkgs, user_settings, ... }: {
    imports = [
    ../../system_modules
    ];

    users.users.${user_settings.username}.shell = pkgs.${user_settings.default_shell};

}