{ pkgs, lib, config, user_settings, ... }: {

    options = {
        vivaldi.enable = lib.mkEnableOption "enables vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {
        # Use Homebrew for Darwin (macOS) systems, home-manager packages for others
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "vivaldi" ];
        home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [
           (vivaldi.override {
             proprietaryCodecs = true;
             enableWidevine = true;
           })
        ]);
    };
}