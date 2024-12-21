_: {
  perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        name = "annt-template-shell";

        inputsFrom = [
          config.pre-commit.devShell
        ];

        packages = with pkgs; [
          just
        ];

        shellHook = ''
          cat <<EOF

            🐚✒️ Get started: 'just <recipe>'
            `just`

          EOF
        '';
      };
    };
}
