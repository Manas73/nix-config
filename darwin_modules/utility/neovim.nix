{ pkgs, lib, config, ... }: {

    options = {
        neovim.enable = lib.mkEnableOption "enables neovim";
    };

    config = lib.mkIf config.neovim.enable  {
        homebrew.casks = [ "neovim" ];
    };
}