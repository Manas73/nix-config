{ pkgs, lib, config, user_settings, ... }: {

    options = {
        onlyoffice.enable = lib.mkEnableOption "enables onlyoffice";
    };

    config = lib.mkIf config.onlyoffice.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "onlyoffice" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ onlyoffice-bin_latest ]);
    };
}