{
  lib,
  stdenv,

  fetchFromGitHub,

  pkg-config,
  automake,
  autoconf,

  lua,
  ffmpeg,
  fontconfig,
  freetype,
  alsa-lib,
  xcb-util-cursor,
  SDL2,
  # , libX11
  # , libXcursor

  qtbase,
  wrapQtAppsHook,
}:

stdenv.mkDerivation rec {
  pname = "libtas";
  version = "1.4.4";

  src = fetchFromGitHub {
    owner = "clementgallet";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-4BtrtvSfPCGUR4Z1HdMLSWbVz3GiaCpbes+YjiLm5NA=";
  };

  nativeBuildInputs = [
    pkg-config
    automake
    autoconf
    wrapQtAppsHook
  ];

  buildInputs = [
    lua
    ffmpeg
    fontconfig
    freetype
    alsa-lib
    xcb-util-cursor
    SDL2
    qtbase
    # libX11
    # libXcursor
  ];

  # dontConfigure = true

  dontWrapQtApps = true;

  preConfigure = ''
    aclocal
    autoconf
    autoheader
    automake --add-missing
  '';

  postFixup = ''
    wrapQtApp $out/bin/libTAS
  '';

  # buildPhase = "./build.sh";
}
