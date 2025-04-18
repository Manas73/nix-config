{ pkgs, lib, config, ... }: {

    options = {
        firefox.enable = lib.mkEnableOption "enables firefox";
    };

    config = lib.mkIf config.firefox.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "firefox" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ firefox ]);
    };
}