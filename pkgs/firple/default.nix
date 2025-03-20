{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "Firple";
  version = "5.000";

  src = fetchzip {
    url = "https://github.com/negset/Firple/releases/download/${version}/Firple.zip";
    hash = "sha256-cVNpL7AJe5xCLFfCPII5eP7xA66WWNqEID2gReM44m0=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/negset/Firple";
    description = "A monospaced Japanese font containing ligatures";
    license = licenses.ofl;
    # maintainers = [ maintainers.rycee ];
    platforms = platforms.all;
  };
}
