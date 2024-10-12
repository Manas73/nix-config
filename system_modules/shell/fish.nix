{ pkgs, lib, config, ... }: {

    options = {
        fish.enable = lib.mkEnableOption "enables fish";
    };

    config = lib.mkIf config.fish.enable  {
        programs.fish.enable = true;
    };
}