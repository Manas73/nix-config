{ pkgs, lib, config, ... }:

let

  # Define the package first
  my-input-remapper = pkgs.input-remapper.overrideAttrs (oldAttrs: rec {
    pname = oldAttrs.pname;
    version = "2.1.1";  # Set to version

    src = pkgs.fetchFromGitHub {
      owner = "sezanzeb";
      repo = "input-remapper";
      rev = version;  # Set to the corresponding commit or tag for version
      hash = "sha256-GMKcs2UK1yegGT/TBsLGgTBJROQ38M6WwnLbJIuAZwg=";  # Replace with correct sha256
    };

    # Adding icon substitution during install
    postInstall = ''
    substituteInPlace data/99-input-remapper.rules \
      --replace-fail 'RUN+="/bin/input-remapper-control' "RUN+=\"$out/bin/input-remapper-control"
    substituteInPlace data/input-remapper.service \
      --replace-fail 'ExecStart=/usr/bin/input-remapper-service' "ExecStart=$out/bin/input-remapper-service"

    install -m644 -D -t $out/share/applications/ data/*.desktop
    install -m644 -D -t $out/share/polkit-1/actions/ data/input-remapper.policy
    install -m644 -D data/99-input-remapper.rules $out/etc/udev/rules.d/99-input-remapper.rules
    install -m644 -D data/input-remapper.service $out/lib/systemd/system/input-remapper.service
    install -m644 -D data/input-remapper.policy $out/share/polkit-1/actions/input-remapper.policy
    install -m644 -D data/inputremapper.Control.conf $out/etc/dbus-1/system.d/inputremapper.Control.conf
    install -m644 -D -t $out/usr/share/input-remapper/ data/*

    # Only install input-remapper prefixed binaries, we don't care about deprecated key-mapper ones
    install -m755 -D -t $out/bin/ bin/input-remapper*
   '';
  });

in

{
  # Options block
  options = {
    input-remapper.enable = lib.mkEnableOption "enables input-remapper";
  };

  # Config block
  config = lib.mkIf config.input-remapper.enable  {
    home.packages = [ my-input-remapper ];
  };
}

