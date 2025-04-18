{ pkgs, lib, config, ... }: {

    options = {
        lazygit.enable = lib.mkEnableOption "enables lazygit";
    };

    config = lib.mkIf config.lazygit.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.lazygit ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ lazygit ]);
    };
}