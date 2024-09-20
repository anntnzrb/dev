{
  inputs,
  ...
}:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  perSystem = _: {
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        actionlint.enable = true;
        prettier.enable = true;

        deadnix = {
          enable = true;
          no-underscore = true;
        };

        statix = {
          enable = true;
          disabled-lints = [ "repeated_keys" ];
        };
      };
    };
  };
}
