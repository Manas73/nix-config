{ pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    age
    chezmoi
    home-manager
    mas
  ];

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "docker"
      "docker-toolbox"
    ];
    masApps = {
      "wireguard" = 1451685025;
    };
  };

  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}