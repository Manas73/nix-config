{ pkgs, lib, config, user_settings, ... }: {

    options = {
        stow.enable = lib.mkEnableOption "enables stow";
    };

    config = lib.mkIf config.stow.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.stow ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ stow ]);
    };
}