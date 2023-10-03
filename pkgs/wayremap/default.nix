{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, python-uinput
, evdev
, i3ipc
}:

buildPythonPackage rec {
  pname = "wayremap";
  version = "0.0.9";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "acro5piano";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Z6qqq3VZKIQXUrq1GQBbPvW1ctGSPSK4TrlfxkvwZUU=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    python-uinput
    evdev
    i3ipc
  ];

  meta = with lib; {
    description = "Dynamic key remapper for Wayland Window System, especially for Sway";
    homepage = "https://github.com/acro5piano/wayremap";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ ];
  };
}
