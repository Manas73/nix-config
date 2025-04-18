{ pkgs, lib, config, ... }: {

    options = {
        zoom.enable = lib.mkEnableOption "enables zoom";
    };

    config = lib.mkIf config.zoom.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "zoom" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ zoom-us ]);
    };
}