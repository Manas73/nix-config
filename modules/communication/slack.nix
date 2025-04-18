{ pkgs, lib, config, user_settings, ... }: {

    options = {
        slack.enable = lib.mkEnableOption "enables slack";
    };

    config = lib.mkIf config.slack.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "slack" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ slack ]);
    };
}