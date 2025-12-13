{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "Firple";
  version = "6.000";

  src = fetchzip {
    url = "https://github.com/negset/Firple/releases/download/${version}/Firple.zip";
    hash = "sha256-Y4BFssRAm+BJ4MOOY6EkPmnrZiQyKGALUZaPgXh7O9Q=";
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
