# ====== Unstable Packages Overlay ====== #
{ self, inputs, ... }: {

  flake.nixosModules.unstable = { config, lib, ... }: {
    _module.args = {
      pkgs-unstable = 
        import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true; # Set as needed
      };
    };
  };
}

