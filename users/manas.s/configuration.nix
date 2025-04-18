{ lib, config, inputs, pkgs, system_settings, user_configurations, ... }:

let
  user_settings = user_configurations."manas.s";
in

{
    imports = [
    ../../modules
    ];

    users.users.${user_settings.username} = {
      home = "/Users/${user_settings.username}";
      shell = pkgs.${user_settings.default_shell};
    };

}
