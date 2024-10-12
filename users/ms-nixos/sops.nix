{
  inputs,
  config,
  user_settings,
  ...
}:
let
  home_directory = config.home.homeDirectory;
in
{
  sops = {
      defaultSopsFile = ../../secrets.yaml;
      age = {
          keyFile = "/home/${user_settings.username}/.config/sops/age/keys.txt";
      };
      secrets = {
          "private_keys/id_ed25519" = {
            path = "${home_directory}/.ssh/id_ed25519";
          };
          "private_keys/manas-gitlab" = {
            path = "${home_directory}/.ssh/Manas-GitLab";
          };
          "private_keys/manas-turing" = {
            path = "${home_directory}/.ssh/Manas-Turing";
          };
          "private_keys/manas73-github" = {
            path = "${home_directory}/.ssh/Manas73-GitHub";
          };
       };
  };
}