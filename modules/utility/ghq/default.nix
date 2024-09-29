{ pkgs, lib, config, username, ... }: {

    options = {
        ghq.enable = lib.mkEnableOption "enables ghq";
    };

    config = lib.mkIf config.ghq.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ ghq ];
        };
    };
}
