{ pkgs, lib, config, username, ... }: {

    options = {
        sublime.enable = lib.mkEnableOption "enables sublime";
    };

    config = lib.mkIf config.sublime.enable  {
        home-manager.users.${username} = {pkgs, ... }: {
            home.packages = with pkgs; [ sublime4 ];
        };

        nixpkgs.config.permittedInsecurePackages = [
            "openssl-1.1.1w"
        ];
        
    };
}
