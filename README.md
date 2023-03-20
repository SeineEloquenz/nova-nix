# nova-nix
This flake packages the [nova](https://github.com/FairwindsOps/nova) tool for the Nix package manager.

# How to
## Run ad hoc
Run `nix run github:SeineEloquenz/nova-nix` in a terminal.
## Add to NixOS systems
Add the following input to your system configuration flake
```
nova = {
  url = "github:SeineEloquenz/nova-nix";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
Use the package inside your configuration as `inputs.nova.packages.x86_64-linux.default`
