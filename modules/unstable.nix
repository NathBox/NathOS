# ====== Unstable Packages Overlay ====== #
{ self, inputs, withSystem, ... }: {

  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: _prev: {
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              inherit system;
            };
          })
        ];
      };
    };

  flake = {
    overlays.default = _final: prev: {
      local = withSystem prev.stdenv.hostPlatform.system ({ config, ... }: config.packages);
    };
  };
}
