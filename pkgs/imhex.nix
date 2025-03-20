{
  lib,
  stdenv,
  cmake,
  fetchFromGitHub,
  mbedtls,
  gtk3,
  pkg-config,
  libGLU,
  glfw3,
  file,
  python3,
  xlibsWrapper,
  dbus,
  cacert,
}:

stdenv.mkDerivation rec {
  pname = "ImHex";
  version = "master";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "WerWolv";
    repo = pname;
    # rev = "v${version}";
    rev = "315109aa1fcedf73b6a48e4dab6ebe66420d7c12";
    sha256 = "sha256-3mR/BlkOrSyvjnXV1+6W47WTPxVSmdn32fu9nDh/4aM=";
  };

  patterns_src = fetchFromGitHub {
    owner = "WerWolv";
    repo = "ImHex-Patterns";
    rev = "f40943c8cd5b799357e86d93736a23784bef3100";
    sha256 = "sha256-Djg/11INid3SGXoMuU13BiKOkELhayhC3mxK3Rr1KJw=";
  };

  nativeBuildInputs = [
    cmake
    python3
    pkg-config
    xlibsWrapper
  ];

  buildInputs = [
    mbedtls
    gtk3
    libGLU
    glfw3
    file
    dbus
    cacert
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DIMHEX_OFFLINE_BUILD=ON"
  ];

  installPhase = ''
    install -D imhex $out/bin/imhex
    install -D plugins/builtin.hexplug $out/bin/plugins/builtin.hexplug
    install -D lib/libimhex/libimhex.so $out/lib/libimhex.so
    cp -R ${patterns_src}/* $out/bin
  '';

  fixupPhase = ''
    fixRpath() {
      rpath=$(patchelf --print-rpath "$1" | sed 's/\/build\/source\/plugins\/libimhex:://g')
      patchelf --set-rpath "$2:$rpath" "$1"
    }
    fixRpath $out/bin/plugins/builtin.hexplug  $out/lib
    fixRpath $out/bin/imhex $out/lib
  '';

  # hardeningDisable = [ "format" ];
  doCheck = false;

  meta = with lib; {
    description = "Hex Editor for Reverse Engineers, Programmers and people who value their retinas when working at 3 AM";
    homepage = "https://github.com/WerWolv/ImHex";
    license = with licenses; [ gpl2Only ];
    platforms = platforms.linux;
  };
}
