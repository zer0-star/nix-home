{ stdenv
, lib
, fetchFromGitHub

, pkg-config
, cmake
, gcc
, jsoncpp
, icu
, readline
, xcb-util-cursor

, qtbase
, qttools
, wrapQtAppsHook
}:

stdenv.mkDerivation rec {
  pname = "med";
  version = "3.8.1";

  src = fetchFromGitHub {
    owner = "allencch";
    repo = pname;
    rev = version;
    hash = "sha256-MCJPHperV8Zb3SQigXOXILRApaMrDYVgNuLSBkeBCi0=";
  };

  nativeBuildInputs = [
    pkg-config
    cmake
    gcc

    wrapQtAppsHook
  ];

  buildInputs = [
    jsoncpp
    icu
    readline

    qtbase
    qttools
    # qtwayland
  ];

  # QT_QPA_PLATFORM_PLUGIN_PATH="${qtbase.bin}/lib/qt-${qtbase.version}/plugins";
  # QT_XCB_GL_INTEGRATION="none";

  installPhase = ''
    runHook preInstall

    mkdir -p $out

    mkdir $out/bin $out/lib

    mv med-cli $out/bin
    mv med-ui $out/bin
    mv libmem_ed.so $out/lib

    for ui in ../ui/*.ui; do
      # mv $ui $out/bin
      mv $ui $out/bin
    done

    # pwd

    # ls -lah ../

    runHook postInstall
  '';
}
