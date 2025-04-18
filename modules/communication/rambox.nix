{ pkgs, pkgs-unstable, lib, config, ... }: {

    options = {
        rambox.enable = lib.mkEnableOption "enables rambox";
    };

    config = lib.mkIf config.rambox.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "rambox" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs-unstable; [ rambox ]);
    };
}