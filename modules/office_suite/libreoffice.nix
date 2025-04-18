{ pkgs, lib, config, ... }: {

    options = {
        libreoffice.enable = lib.mkEnableOption "enables libreoffice";
    };

    config = lib.mkIf config.libreoffice.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "libreoffice" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ libreoffice-still ]);
    };
}