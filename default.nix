{ lib
, fetchFromGitHub
, buildGoModule
}:
let

in buildGoModule rec {

  pname = "nova";
  version = "3.9.0";

  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = "v${version}";
    hash = "sha256-9ccWH0bh67LCwzKmyaE32j+qeKfNauclSMjpRwdblH8=";
  };

  vendorHash = "sha256-Vt2yUYm2i1NHzW7GxDRqBpaFS4dLfODNEMPO+CTwrLY=";

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
