{ pkgs, lib, config, ... }: {

    options = {
        fzf.enable = lib.mkEnableOption "enables fzf";
    };

    config = lib.mkIf config.fzf.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.fzf ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ fzf ]);
    };
}