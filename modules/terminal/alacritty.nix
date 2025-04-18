{ pkgs, lib, config, user_settings, ... }: {

    options = {
        alacritty.enable = lib.mkEnableOption "enables alacritty";
    };

    config = lib.mkIf config.alacritty.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "alacritty" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ alacritty ]);
    };
}