{ pkgs, lib, config, user_settings, ... }: {

    options = {
        postman.enable = lib.mkEnableOption "enables postman";
    };

    config = lib.mkIf config.postman.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "postman" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ postman ]);
    };
}