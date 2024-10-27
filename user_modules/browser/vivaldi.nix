{ pkgs, lib, config, system_settings, user_settings, ... }: {

    options = {
        vivaldi.enable = lib.mkEnableOption "enables vivaldi";
    };

    config = lib.mkIf config.vivaldi.enable {
        home.packages = lib.mkIf (!system_settings.is_darwin) (with pkgs; [
            (vivaldi.override {
                proprietaryCodecs = true;
                enableWidevine = true;
            })
        ]);

        homebrew.casks = lib.mkIf system_settings.is_darwin [ "vivaldi" ];
    };
}