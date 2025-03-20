{
  lib,
  stdenv,
  ocamlPackages,
  fetchFromGitHub,
}:

ocamlPackages.buildDunePackage rec {
  pname = "malfunction";
  version = "0.4.1";
  src = fetchFromGitHub {
    owner = "stedolan";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-yH9LV4PqcsS4tc0gbeG5SnwOmn35sJRA2BLJLAu7mt0=";
  };
  duneVersion = "3";
  nativeBuildInputs = with ocamlPackages; [ cppo ];
  propagatedBuildInputs = with ocamlPackages; [
    zarith
    omd
    findlib
  ];
}
