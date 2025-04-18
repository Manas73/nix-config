{ pkgs, lib, config, ... }: {

    options = {
        chezmoi.enable = lib.mkEnableOption "enables chezmoi";
    };

    config = lib.mkIf config.chezmoi.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.chezmoi ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ chezmoi ]);
    };
}