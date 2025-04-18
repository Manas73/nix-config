{ pkgs, lib, config, user_settings, ... }: {

    options = {
        yazi.enable = lib.mkEnableOption "enables yazi";
    };

    config = lib.mkIf config.yazi.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.yazi ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ yazi ]);
    };
}