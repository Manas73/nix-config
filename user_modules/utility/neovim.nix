{ pkgs, lib, config, ... }: {

    options = {
        neovim.enable = lib.mkEnableOption "enables neovim";
    };

    config = lib.mkIf config.neovim.enable  {
        home.packages = with pkgs; [ neovim ];
    };
}
