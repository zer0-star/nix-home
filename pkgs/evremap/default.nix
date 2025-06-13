{
  lib,
  fetchFromGitHub,

  rustPlatform,

  pkg-config,
  libevdev,
}:

rustPlatform.buildRustPackage rec {
  pname = "evremap";
  version = "master";

  src = fetchFromGitHub {
    owner = "wez";
    repo = pname;
    rev = "cc618e8b973f5c6f66682d1477b3b868a768c545";
    hash = "sha256-aAAnlGlSFPOK3h8UuAOlFyrKTEuzbyh613IiPE7xWaA=";
  };

  cargoHash = "sha256-3KXvRbPHM78IGe7Hl8AEHCmK0onroQycyTfOm942e9Y=";

  cargoPatches = [
    # ./cargo-lock.patch
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libevdev
  ];

  meta = with lib; {
    description = "A keyboard input remapper for Linux/Wayland systems, written by @wez";
    homepage = "https://github.com/wez/evremap";
    license = licenses.mit;
    maintainers = [ ];
  };
}
