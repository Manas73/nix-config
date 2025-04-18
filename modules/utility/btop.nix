{ pkgs, lib, config, user_settings, ... }: {

    options = {
        btop.enable = lib.mkEnableOption "enables btop";
    };

    config = lib.mkIf config.btop.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.btop ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ btop ]);
    };
}