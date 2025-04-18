{ pkgs, lib, config, user_settings, ... }: {

    options = {
        teams.enable = lib.mkEnableOption "enables teams";
    };

    config = lib.mkIf config.teams.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "microsoft-teams" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ teams ]);
    };
}