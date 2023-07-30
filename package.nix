{ lib
, fetchFromGitHub
, buildGoModule
}:
let

in buildGoModule rec {

  pname = "nova";
  version = "3.6.4";

  src = fetchFromGitHub {
    owner = "FairwindsOps";
    repo = "nova";
    rev = "${version}";
    hash = "sha256-6gTrBogMvM7X6PFthG+c8N9wXoNHwp0wHjGVKjiHJJY=";
  };

  vendorHash = "sha256-YvYfSb2ZC86S2osFRG7Ep9nrgYJV0tB8fBgZQZ07t2U=";

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
