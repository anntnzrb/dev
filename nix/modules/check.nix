{
  inputs,
  ...
}:
{
  imports = [ (inputs.pre-commit-hooks + /flake-module.nix) ];

  perSystem =
    {
      pkgs,
      config,
      ...
    }:
    {
      pre-commit.settings.hooks = {
        flake-checker.enable = true;
        actionlint.enable = true;

        deadnix = {
          enable = true;
          settings = {
            edit = true;
            noUnderscore = true;
          };
        };

        statix =
          let
            cfg = (pkgs.formats.toml { }).generate "statix.toml" { disabled = disabled-lints; };
            disabled-lints = [ "repeated_keys" ];
          in
          {
            enable = true;
            package = pkgs.writeShellApplication {
              name = "statix";
              runtimeInputs = [ pkgs.statix ];
              text = ''
                shift
                exec statix check --config ${cfg} "$@"
              '';
            };
          };
      };

      checks.default = config.checks.pre-commit;
    };
}
