{
  description = "Simple tool checking for outdated helm charts and container versions in kubernetes clusters";

  outputs = { self, nixpkgs }: 
  let

    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

  in {

    packages.${system} = {
      nova = pkgs.callPackage ./package.nix {};
      default = self.packages.x86_64-linux.nova;
    };
  };
}
