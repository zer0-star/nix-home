{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "ante";
  version = "2022-06-20";

  src = fetchFromGitHub {
    owner = "jfecher";
    repo = pname;
    rev = "d5765a06eee5a93768f80dfaf71316fc15b71c6b";
    hash = "sha256-hZWp4NITljBZmqkZSk+CrmMfg8ElE/uzDPvSkkxlA9w=";
  };

  cargoHash = "sha256-prEew8cAfzjmtUwez/xmXBtjhXOXtXWWBjCXa82xKMs=";

  cargoPatches = [ ./cargo-lock.patch ];
}
