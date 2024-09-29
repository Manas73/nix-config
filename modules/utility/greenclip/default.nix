{ pkgs, lib, config, username, ... }: {

    options = {
        greenclip.enable = lib.mkEnableOption "enables greenclip";
    };

    config = lib.mkIf config.greenclip.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ haskellPackages.greenclip ];
        };
    };
}
