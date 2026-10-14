{
  lib,
  buildPythonPackage,
  hatchling,

  fetchPypi,

  libxcb,
}:

buildPythonPackage rec {
  pname = "pdf2zh";
  version = "1.9.11";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-gTXT0LdtJBZDeyJFKF3+as9XZyPlIZiJtKSWCyZ/TLQ=";
  };

  buildIpnuts = [ libxcb ];

  build-system = [ hatchling ];
}
