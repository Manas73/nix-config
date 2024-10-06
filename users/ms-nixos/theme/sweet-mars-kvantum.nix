{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "Sweet-Mars";
  src = pkgs.fetchFromGitHub {
    owner = "EliverLara";
    repo = "Sweet";
    rev = "ffd90ad94214dba8998e10dccadf1bef50ab43f8";
    sha256 = "GalTNO+G6MJB63EmC4q2Gb3mnTJm2GtSbKS1Mu97oMc=";
  };

  installPhase = ''
    mkdir -p $out/share/Kvantum
    cp -a kde/kvantum/Sweet-Mars $out/share/Kvantum
  '';
}
