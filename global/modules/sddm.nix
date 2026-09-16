{ self, inputs, ... }: {

  flake.nixosModules.sddm = { config, pkgs, ... }: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = with pkgs; [
       sddm-chili-theme
      ]; 
      theme = "sddm-chili-theme";
    };
    
    environment.systemPackages = with pkgs; [
      sddm-chili-theme
    ];
  };
}
