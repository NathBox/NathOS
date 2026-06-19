{ self, inputs, ... }: {

  # ====== Gaming ====== 
  flake.nixosModules.gaming = { config, pkgs, pkgs-unstable, ... }: {


    # ====== Steam ====== 
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
   
    # ====== Gaming Packages ====== 
    environment.systemPackages = with pkgs; [
 
      # ====== Launchers ======
      #prismlauncher 
      (lutris.override {
        extraLibraries = pkgs: [ ];
        extraPkgs = pkgs: [ ];
      })
      
      # ====== Games ======
      fallout-ce
      #fallout2-ce
      #ioquake3
      #clonehero
      #iw4x-launcher
      #osu-lazer-bin
      
      # ====== Emulation ======
      dolphin-emu
      rpcs3
      #pcsx2
      #nestopia-ue
      #snes9x
      #ares
      #vbam # visualboyadvanced
      #mgba
   
      # ====== Tools ======
      protonup-ng
      protontricks
      mangohud
      mangojuice
      lsfg-vk
      lsfg-vk-ui
      #python313Packages.ds4drv
      #rusty-path-of-building  
    ];
  };
}
