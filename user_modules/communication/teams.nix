{ pkgs, lib, config, user_settings, ... }: {

    options = {
        teams.enable = lib.mkEnableOption "enables teams";
    };

    config = lib.mkIf config.teams.enable  {
        home.packages = with pkgs; [ teams ];
    };
}
