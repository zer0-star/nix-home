{ lib
, fetchFromGitHub

, rustPlatform

, pkg-config
, libevdev
}:

rustPlatform.buildRustPackage rec {
  pname = "evremap";
  version = "master";

  src = fetchFromGitHub {
    owner = "wez";
    repo = pname;
    rev = "d64c90e6fa8631bc519db3c8aceb5ad27f024e00";
    hash = "sha256-7fS42x+YLci9HG0IL58IBS4qxHLZdk3YlPHseZzJ/ag=";
  };

  cargoHash = "sha256-I+iHJP/LVwJ0vGjuvZbI/uu8oqZb0baE5xtYAy2Jeu4=";

  cargoPatches = [
    ./cargo-lock.patch
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
