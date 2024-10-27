{ pkgs, lib, config, user_settings, ... }: {

    options = {
        vivaldi.enable = lib.mkEnableOption "enables vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {
        home.packages = lib.mkIf (pkgs.stdenv.isLinux) (with pkgs; [
            (vivaldi.override {
                proprietaryCodecs = true;
                enableWidevine = true;
            })
        ]);

        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "vivaldi" ];
    };
}