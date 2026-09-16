{ self, inputs, ... }: {

  # ====== Mullvad VPN ====== 
  flake.nixosModules.mullvad = { config, pkgs, pkgs-unstable, ... }: {
    services.mullvad-vpn = { 
      enable = true;
     # package = pkgs-unstable.mullvad-vpn;
    };
  };
}
