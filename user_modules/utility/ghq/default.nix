{ pkgs, lib, config, user_settings, ... }: {

    options = {
        ghq.enable = lib.mkEnableOption "enables ghq";
    };

    config = lib.mkIf config.ghq.enable  {
        home.packages = with pkgs; [ ghq ];
    };
}
