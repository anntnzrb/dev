{
  inputs,
  ...
}:
{
  flake.templates = {
    default = inputs.self.templates.dev;

    dev = {
      description = "A {nix,flake}-enabled project template for pretty much any type of development";
      path = builtins.path { path = inputs.self; };
    };
  };
}
