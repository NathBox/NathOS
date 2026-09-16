
# ====== Noctalia Shell ====== #

{ self, inputs, ... }: {

  flake.nixosModules.noctalia = { config, pkgs, ... }: {
     environment.systemPackages = with pkgs; [ noctalia-shell ];
  };

}
