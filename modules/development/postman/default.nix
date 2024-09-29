{ pkgs, lib, config, username, ... }: {

    options = {
        postman.enable = lib.mkEnableOption "enables postman";
    };

    config = lib.mkIf config.postman.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ postman ];
        };
    };
}
