{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,

  pycryptodome,
}:

buildPythonPackage rec {
  pname = "ptrlib";
  version = "3.1.1";

  format = "setuptools";

  src = fetchFromGitHub {
    owner = "ptr-yudai";
    repo = "ptrlib";
    rev = "df951c0ce62a4e6eea860766813aea8839c48911";
    hash = "sha256-WrnLq4vx9nFWR4VfJCyHzrg0RqG3nt259myg/zhjsx8=";
  };

  propagatedBuildInputs = [
    pycryptodome
  ];
}
