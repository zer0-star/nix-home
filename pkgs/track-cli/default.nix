{
  lib,
  stdenv,
  fetchurl,

  autoPatchelfHook,
  unzip,

  openssl_1_1,
  gcc,
}:

stdenv.mkDerivation rec {
  pname = "track-cli";
  version = "latest";

  src = fetchurl {
    url = "https://s3-ap-northeast-1.amazonaws.com/track-cli/downloads/linux_x86_64/track.zip";
    hash = "sha256-3oiFRjeEKDdfLBufchvBhWcpWvnluB0BxOCfwCRFlxo=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
  ];

  buildInputs = [
    openssl_1_1
    gcc.cc.lib
  ];

  sourceRoot = ".";

  installPhase = ''
    install -m755 -D track $out/bin/track
  '';
}
