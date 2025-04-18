{ pkgs, lib, config, ... }: {

    options = {
        pyenv.enable = lib.mkEnableOption "enables pyenv";
    };

    config = lib.mkIf config.pyenv.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.pyenv ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ pyenv ]);
    };
}