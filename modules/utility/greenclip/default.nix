{ pkgs, lib, config, user_settings, ... }: {

    options = {
        greenclip.enable = lib.mkEnableOption "enables greenclip";
    };

    config = lib.mkIf config.greenclip.enable  {
        home.packages = with pkgs; [ haskellPackages.greenclip ];
    };
}
