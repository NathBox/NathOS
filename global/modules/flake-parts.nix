
# ====== Flake Parts ====== #

  { inputs, ... }: {
    imports = [
      inputs.home-manager.flakeModules.home-manager
      inputs.disko.flakeModules.default
    ];

    config.systems = [ 
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  }
