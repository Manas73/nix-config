{ pkgs, lib, config, ... }: {

    options = {
        sublime.enable = lib.mkEnableOption "enables sublime";
    };

    config = lib.mkIf config.sublime.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "sublime-text" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ sublime4 ]);
    };
}