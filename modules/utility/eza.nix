{ pkgs, lib, config, user_settings, ... }: {

    options = {
        eza.enable = lib.mkEnableOption "enables eza";
    };

    config = lib.mkIf config.eza.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.eza ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ eza ]);
    };
}