{ pkgs, lib, config, system_settings, ... }: {

    options = {
        slack.enable = lib.mkEnableOption "enables slack";
    };

    config = lib.mkIf config.slack.enable  {
        homebrew.casks = [ "slack" ];
    };
}
