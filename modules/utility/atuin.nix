{ pkgs, lib, config, ... }: {

    options = {
        atuin.enable = lib.mkEnableOption "enables atuin";
    };

    config = lib.mkIf config.atuin.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.atuin ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ atuin ]);
    };
}