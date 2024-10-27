{ pkgs, lib, config, system_settings, ... }: {

    options = {
        atuin.enable = lib.mkEnableOption "enables atuin";
    };

    config = lib.mkIf config.atuin.enable  {
        homebrew.casks = [ "atuin" ];
    };
}
