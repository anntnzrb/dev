{
  inputs,
  ...
}:
let
  devenvRootFile = builtins.readFile inputs.devenv-root.outPath;
in
{
  imports = [ inputs.devenv.flakeModule ];
  perSystem =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      devenv.shells.default = {
        name = "annt-devenv-template-shell";
        devenv.root = lib.mkIf (devenvRootFile != "") devenvRootFile;

        languages = {
          nix.enable = true;
        };

        packages = with pkgs; [
          just
          config.treefmt.build.wrapper
        ];

        enterShell = ''
          cat <<EOF

            🐚✒️ Get started: 'just <recipe>'
            `just`

          EOF
        '';
      };
    };
}
