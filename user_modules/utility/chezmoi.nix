{ pkgs, lib, config, ... }: {

    options = {
        chezmoi.enable = lib.mkEnableOption "enables chezmoi";
    };

    config = lib.mkIf config.chezmoi.enable  {
        home.packages = with pkgs; [ chezmoi ];
    };
}
