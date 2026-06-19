{ self, inputs, ... }: {

  # ====== XDG ====== #
  flake.nixosModules.xdg = { config, pkgs, ... }: {
    xdg.portal = {
      enable = true;
      extraPortals = (with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ]);
    };
  };
}
