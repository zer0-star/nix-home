{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "satysfi-language-server";
  version = "master";

  useFetchCargoVendor = true;

  src = fetchFromGitHub {
    owner = "monaqa";
    repo = pname;
    rev = "c48b59c248b5e4deb6dc9cd6a2a0df27af53bbce";
    hash = "sha256-SkMP33VOKMDgCuxWWZhsITUpwZo13NPDRO0nuHYIBN8=";
  };

  cargoHash = "sha256-dRkKekfo2lVhTh/NIE5mOuRHARyhahC+/sWcxsK/iKc=";

  meta = with lib; {
    description = "A fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = licenses.unlicense;
    maintainers = [ maintainers.tailhook ];
  };
}
