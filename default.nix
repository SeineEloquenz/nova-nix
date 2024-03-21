{ lib
, fetchFromGitHub
, buildGoModule
}:
let

in buildGoModule rec {

  pname = "nova";
  version = "3.8.0";

  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = "v${version}";
    hash = "sha256-3bSxMb/JFIy3b6N/94cXfGlUbPIm046O9m2KPan8YIs=";
  };

  vendorHash = "sha256-c30B8Wjvwp4NnB1P8h4/raGiGAX/cbTZ/KQqh/qeNhA=";

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
    mkdir -p $out/share/fish/vendor_completions.d
    $out/bin/nova completion fish > $out/share/fish/vendor_completions.d/nova.fish
    chmod +x $out/share/fish/vendor_completions.d/nova.fish
  '';

  meta = with lib; {
    description = "Simple tool checking for outdated helm charts and container versions in kubernetes clusters";
    homepage = "https://github.com/FairwindsOps/nova";
    license = licenses.asl20;
  };
}
