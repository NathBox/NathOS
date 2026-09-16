# ====== Spotify Overlay ======
{ self, inputs, ...}: {
  
  flake.nixosModules.spotify = { config, pkgs, ... }: {
   
   nixpkgs.overlays = [inputs.oskars-dotfiles.overlays.spotx]; 
   environment.systemPackages = with pkgs; [ spotify ];

 };
}
