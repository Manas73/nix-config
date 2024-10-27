{ pkgs, lib, config, system_settings, ... }: {

    options = {
        sublime.enable = lib.mkEnableOption "enables sublime";
    };

    config = lib.mkIf config.sublime.enable  {
        homebrew.casks = [ "sublime-text" ];
    };
}
