{ pkgs, lib, config, system_settings, ... }: {

    options = {
        postman.enable = lib.mkEnableOption "enables postman";
    };

    config = lib.mkIf config.postman.enable  {
        homebrew.casks = [ "postman" ];
    };
}
