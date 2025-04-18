{ pkgs, lib, config, user_settings, ... }: {

    options = {
        datagrip.enable = lib.mkEnableOption "enables datagrip";
    };

    config = lib.mkIf config.datagrip.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "datagrip" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ jetbrains.datagrip ]);
    };
}