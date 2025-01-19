{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "juisee";
  version = "0.2.0";

  src = fetchzip {
    url = "https://github.com/yuru7/juisee/releases/download/v${version}/Juisee_v${version}.zip";
    hash = "sha256-Ik8k24uxenBcp8v9BqloNGgai98cqtSUxp8P+2L5YuU=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/yuru7/juisee";
    description = "Juisee は、欧文フォント JuliaMono と日本語フォント LINE Seed JP を合成したプログラミング向けフォントです。";
    license = licenses.ofl;
    # maintainers = [ maintainers.rycee ];
    platforms = platforms.all;
  };
}
