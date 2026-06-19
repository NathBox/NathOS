
# ====== Noctalia Shell ====== #

{ self, inputs, ... }: {

#  flake.nixosModules.noctalia = { config, pkgs, ... }: {
#    noctalia-shell = {
#      enable = true;
#      settings = 
#        (builtins.fromJSON
#          (builtins.readFile ./noctalia.json)).settings;
#      };
#    }; 
}
