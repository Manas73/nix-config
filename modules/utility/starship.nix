{ pkgs, lib, config, ... }: {

    options = {
        starship.enable = lib.mkEnableOption "enables starship";
    };

    config = lib.mkIf config.starship.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.starship ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ starship ]);
    };
}