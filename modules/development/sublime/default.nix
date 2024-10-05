{ pkgs, lib, config, user_settings, ... }: {

    options = {
        sublime.enable = lib.mkEnableOption "enables sublime";
    };

    config = lib.mkIf config.sublime.enable  {
        home.packages = with pkgs; [ sublime4 ];

        nixpkgs.config.permittedInsecurePackages = [
            "openssl-1.1.1w"
        ];

    };
}
