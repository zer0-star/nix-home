{ stdenvNoCC, stdenv
, lib
, dpkg, autoPatchelfHook, makeWrapper
, fetchurl
, alsa-lib, openssl, udev, ffmpeg_4, curl
, libglvnd
, libX11, libXcursor, libXi, libXrandr, libXfixes
, libpulseaudio
, libva
, libpng, libjpeg
}:

stdenvNoCC.mkDerivation {
  pname = "parsec-bin";
  version = "150-86e";

  src = fetchurl {
    url = "https://builds.parsec.app/package/parsec-linux.deb";
    hash = "sha256-wwBy86TdrHaH9ia40yh24yd5G84WTXREihR+9I6o6uU=";
  };

  unpackPhase = ''
    runHook preUnpack

    dpkg-deb -x $src .

    runHook postUnpack
  '';

  nativeBuildInputs = [ dpkg autoPatchelfHook makeWrapper ];

  buildInputs = [
    stdenv.cc.cc # libstdc++
    libglvnd
    libX11
  ];

  runtimeDependenciesPath = lib.makeLibraryPath [
    stdenv.cc.cc
    libglvnd
    openssl
    udev
    alsa-lib
    libpulseaudio
    libva
    libpng
    libjpeg
    ffmpeg_4
    curl
    libX11
    libXcursor
    libXi
    libXrandr
    libXfixes
  ];

  prepareParsec = ''
    if [[ ! -e "$HOME/.parsec/appdata.json" ]]; then
      mkdir -p "$HOME/.parsec"
      cp --no-preserve=mode,ownership,timestamps ${placeholder "out"}/share/parsec/skel/* "$HOME/.parsec/"
    fi
  '';

  installPhase = ''
    runHook preInstall

    mkdir $out
    mv usr/* $out

    wrapProgram $out/bin/parsecd \
      --prefix LD_LIBRARY_PATH : "$runtimeDependenciesPath" \
      --run "$prepareParsec"

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://parsec.app/";
    description = "Remote streaming service client";
    license = licenses.unfree;
    # maintainers = with maintainers; [ arcnmx ];
    platforms = platforms.linux;
    mainProgram = "parsecd";
  };
}
