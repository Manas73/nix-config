{ lib, config, inputs, pkgs, user_configurations, ... }:

let
  user_settings = user_configurations."ms-nixos";
in

{
    imports = [
    ../../modules
    ];

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    };

    sops = {
        defaultSopsFile = ../../secrets.yaml;
        age = {
            keyFile = "/home/${user_settings.username}/.config/sops/age/keys.txt";
        };
        secrets = {
            "${user_settings.username}/password" = {
                neededForUsers = true;
            };
        };
    };

    # Ensure the uinput group exists
    users.groups.uinput = { };

    users.mutableUsers = false;   # Requried for password to be set via sops during system activation!
    users.users.${user_settings.username} = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."${user_settings.username}/password".path;
      shell = pkgs.${user_settings.default_shell};
      description = user_settings.full_name;
      extraGroups = [ "networkmanager" "wheel" "uinput" ];
      packages = with pkgs; [];
    };

    users.users.root = {
      hashedPasswordFile = config.users.users.${user_settings.username}.hashedPasswordFile;
      password = lib.mkForce config.users.users.${user_settings.username}.password;
      openssh.authorizedKeys.keys = config.users.users.${user_settings.username}.openssh.authorizedKeys.keys;
    };


    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
      };
    };

   # Add the Kanata service user to necessary groups
   systemd.services.kanata-default.serviceConfig = {
      SupplementaryGroups = [
        "input"
        "uinput"
      ];
   };

   services.kanata = {
    enable = true;
    keyboards = {
      default.extraDefCfg = "process-unmapped-keys yes";
      default.config = ''
      ;; Kanata Keyboard Configuration for Programming with Home-Row Mods


      ;; Define aliases for the home-row mods and other tap-hold keys
      (defalias
        ;; Home row mods - left hand
        alt_a (tap-hold 200 200 a lalt)  ;; A key: tap for 'a', hold for left Alt
        sft_s (tap-hold 200 200 s lsft)  ;; S key: tap for 's', hold for left Shift
        ctl_d (tap-hold 200 200 d lctl)  ;; D key: tap for 'd', hold for left Control

        ;; Home row mods - right hand
        ctl_j (tap-hold 200 200 j rctl)  ;; J key: tap for 'j', hold for right Control
        sft_k (tap-hold 200 200 k rsft)  ;; K key: tap for 'k', hold for right Shift
        alt_l (tap-hold 200 200 l lalt)  ;; L key: tap for 'l', hold for left Alt
        met_; (tap-hold 200 200 ; rmet)  ;; ; key: tap for ';', hold for right Super/Meta

        ;; Existing mapping: Caps Lock as Esc/Super
        esc_met (tap-hold 200 200 esc lmet)  ;; Caps: tap for Escape, hold for left Super/Meta
      )

      ;; Source keys (standard QWERTY layout)
      (defsrc
        esc  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )

      ;; Main layer with home row mods
      (deflayer main
        esc  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @esc_met @alt_a @sft_s @ctl_d f    g    h    @ctl_j @sft_k @alt_l @met_; '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl
      )
      '';
    };
  };
}
