{
  inputs,
  config,
  configVars,
  ...
}:
let
  home_directory = config.home.homeDirectory;
in
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    # This is the location of the host specific age-key for ta and will to have been extracted to this location via hosts/common/core/sops.nix on the host
    age.keyFile = "${home_directory}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

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