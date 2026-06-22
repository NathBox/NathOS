
# ====== Hyprland ====== #

{ self, inputs, ... }: {

  flake.nixosModules.hyprland = { config, pkgs, lib, ... }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
      systemd.setPath.enable = true;
    };

    programs.uwsm.enable = true; 
  };
  
  flake.homeModules.myHyprland = { config, ... }: {
    home.file = {
      ".config/hypr/hyprland.lua" = {
        source = ./hypr/hyprland.lua;
        recursive = true;
      };
    };
  };
}

