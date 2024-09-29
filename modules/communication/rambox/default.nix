{ pkgs, lib, config, username, ... }: {

    options = {
        rambox.enable = lib.mkEnableOption "enables rambox";
    };

    config = lib.mkIf config.rambox.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ rambox ];
        };
    };
}
