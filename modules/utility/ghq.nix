{ pkgs, lib, config, user_settings, ... }: {

    options = {
        ghq.enable = lib.mkEnableOption "enables ghq";
    };

    config = lib.mkIf config.ghq.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.ghq ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ ghq ]);
    };
}