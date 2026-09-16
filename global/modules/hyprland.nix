{ self, inputs, ... }: {
   
  # ====== Hyprland ======
  flake.nixosModules.hyprland = { config, pkgs, lib, ... }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;

    xwayland.enable = true;
      systemd.setPath.enable = true;
    };

    programs.uwsm.enable = true; 
    
    # ====== Environment Variables ====== 
    environment = {
      sessionVariables = {
        WLR_HARDWARE_CURSORS = "1";
      };
    };
  };
  
}

