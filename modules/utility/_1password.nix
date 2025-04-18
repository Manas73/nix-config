{ pkgs, lib, config, user_settings, ... }: {

    options = {
        _1password.enable = lib.mkEnableOption "enables 1password";
    };

    config = lib.mkIf config._1password.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "1password" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ _1password _1password-gui ]);
    };
}