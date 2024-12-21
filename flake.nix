{
  description = "A {nix,flake}-enabled project template for pretty much any type of development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default/main";
    flake-parts.url = "github:hercules-ci/flake-parts/main";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # formatter
    treefmt-nix.url = "github:numtide/treefmt-nix/main";
    treefmt-nix.flake = false;

    # pre-commit
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    pre-commit-hooks.flake = false;
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports =
        let
          modulesDir = ./nix/modules;
        in
        with builtins;
        map (mod: "${modulesDir}/${mod}") (attrNames (readDir modulesDir));
    };
}
