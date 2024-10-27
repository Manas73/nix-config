{ pkgs, lib, config, system_settings, ... }: {

    options = {
        raycast.enable = lib.mkEnableOption "enables raycast";
    };

    config = lib.mkIf config.raycast.enable  {
        homebrew.casks = [ "raycast" ];
    };
}
