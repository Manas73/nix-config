{ pkgs, lib, config, user_settings, ... }: {

    options = {
        atuin.enable = lib.mkEnableOption "enables atuin";
    };

    config = lib.mkIf config.atuin.enable  {
        home.packages = with pkgs; [ atuin ];
    };
}
