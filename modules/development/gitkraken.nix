{ pkgs, lib, config, user_settings, ... }: {

    options = {
        gitkraken.enable = lib.mkEnableOption "enables gitkraken";
    };

    config = lib.mkIf config.gitkraken.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "gitkraken" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ gitkraken ]);
    };
}