{ pkgs, lib, config, user_settings, ... }: {

    options = {
        zellij.enable = lib.mkEnableOption "enables zellij";
    };

    config = lib.mkIf config.zellij.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.zellij ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ zellij ]);
    };
}