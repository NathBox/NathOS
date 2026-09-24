{ self, inputs, ... }: {

  # ====== Distrobox ======
  flake.nixosModules.distrobox = { config, pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [
      distrobox
      podman
    ];
  };
}
