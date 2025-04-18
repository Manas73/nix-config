{ pkgs, lib, config, ... }: {

    options = {
        pycharm-professional.enable = lib.mkEnableOption "enables pycharm-professional";
    };

    config = lib.mkIf config.pycharm-professional.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "pycharm" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ jetbrains.pycharm-professional ]);
    };
}