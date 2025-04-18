{ pkgs, lib, config, user_settings, ... }: {

    options = {
        brave.enable = lib.mkEnableOption "enables brave";
    };

    config = lib.mkIf config.brave.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "brave-browser" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ brave ]);
    };
}