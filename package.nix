{ lib
, fetchFromGitHub
, buildGoModule
}:
let

in buildGoModule rec {

  pname = "nova";
  version = "3.6.2";

  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = "v${version}";
    sha256 = "19nz2hx92nzgcr76x7abbg2ica59anby1qqbz53yky7938x3v7m4";
  };

  vendorHash = "sha256-vSv9wRmVSbB4hw2Tq3nubV5gjrBSIh98VMLPP7j32+Y=";

  ldflags = [
    "-X main.version=${version}"
  ];

  postInstall = ''
    mkdir -p $out/share/zsh/site-functions
    $out/bin/nova completion zsh > $out/share/zsh/site-functions/_nova
    chmod +x $out/share/zsh/site-functions/_nova
    mkdir -p $out/share/bash-completion/completions
    $out/bin/nova completion bash > $out/share/bash-completion/completions/nova
    chmod +x $out/share/bash-completion/completions/nova
  '';

  meta = with lib; {
    description = "Simple tool checking for outdated helm charts and container versions in kubernetes clusters";
    homepage = "https://github.com/FairwindsOps/nova";
    license = licenses.asl20;
  };
}
