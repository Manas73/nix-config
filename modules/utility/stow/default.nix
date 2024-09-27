{ pkgs, lib, config, username, ... }: {

    options = {
        stow.enable = lib.mkEnableOption "enables stow";
    };

    config = lib.mkIf config.stow.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ stow ];
        };
    };
}
