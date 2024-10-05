{ pkgs, lib, config, user_settings, ... }: {

    options = {
        postman.enable = lib.mkEnableOption "enables postman";
    };

    config = lib.mkIf config.postman.enable  {
        home.packages = with pkgs; [ postman ];
    };
}
