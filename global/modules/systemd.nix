{ self, inputs, ... }: {

  # ====== SystemD Boot-Loader ======  
  flake.nixosModules.systemd = { config, pkgs, ... }: {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };
}
