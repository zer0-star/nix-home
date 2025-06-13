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
    rev = "1ce6bc4d08eb748aeb10f69498e4a16f01978535";
    hash = "sha256-4EmLDsCrJXzQb72JrGGPR7+gAQKcniVGrBnrl9JanBs=";
  };

  cargoHash = "sha256-HvjiYK4x15n6KVKHEnpW9nLGYDixRczMp1isiobybVk=";

  meta = with lib; {
    description = "A fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = licenses.unlicense;
    maintainers = [ maintainers.tailhook ];
  };
}
