{ pkgs, lib, config, system_settings, ... }: {

    options = {
        teams.enable = lib.mkEnableOption "enables teams";
    };

    config = lib.mkIf config.teams.enable  {
        homebrew.casks = [ "microsoft-teams" ];
    };
}
