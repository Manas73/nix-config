{ pkgs, lib, config, username, ... }: {

    options = {
        atuin.enable = lib.mkEnableOption "enables atuin";
    };

    config = lib.mkIf config.atuin.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ atuin ];
        };
    };
}
