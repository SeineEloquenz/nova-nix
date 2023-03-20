{
, lib
, fetchFromGithub
, buildGoModule
}:
let

in buildGoModule {

  pname = "nova";
  version = "3.6.2";

  src = fetchFromGithub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = version;
    sha256 = "";
  };

  meta = with lib; {
    description = "Simple tool checking kubernetes clusters for updated helm charts and container versions";
    homepage = "https://github.com/FairwindsOps/nova";
    license = licenses.apache2;
  };
}
