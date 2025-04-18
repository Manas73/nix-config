{ pkgs, lib, config, ... }: {

    options = {
        neovim.enable = lib.mkEnableOption "enables neovim";
    };

    config = lib.mkIf config.neovim.enable {
        # Use environment.systemPackages for Darwin (macOS) systems, home.packages for others
        environment.systemPackages = lib.mkIf pkgs.stdenv.isDarwin [ pkgs.neovim ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ neovim ]);
    };
}