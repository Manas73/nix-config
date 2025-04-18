{ pkgs, lib, config, user_settings, ... }: {

    options = {
        kitty.enable = lib.mkEnableOption "enables kitty";
    };

    config = lib.mkIf config.kitty.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "kitty" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ kitty ]);
    };
}