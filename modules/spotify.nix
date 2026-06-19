# ====== Spotify Overlay ======
{ self, inputs, ...}: {
  
  flake.nixosModules.spotify = { config, pkgs, ... }: {

    nixpkgs.overlays = [
    (final: prev: {
      spotify = prev.spotify.overrideAttrs (oldAttrs: {
        installPhase = builtins.replaceStrings
          [ "runHook postInstall" ]
          [ ''
            bash <(curl -sSL https://spotx-official.github.io/run.sh) -P "$out/share/spotify"
            runHook postInstall
          '' ]
          oldAttrs.installPhase;
      });
     })
    ];
    environment.systemPackages = with pkgs; [ spotify ];
 };
}
