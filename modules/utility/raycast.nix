{ pkgs, lib, config, user_settings, ... }: {

    options = {
        raycast.enable = lib.mkEnableOption "enables raycast";
    };

    config = lib.mkIf config.raycast.enable {
        # Raycast is only available on macOS
        homebrew.casks = lib.mkIf pkgs.stdenv.isDarwin [ "raycast" ];
    };
}