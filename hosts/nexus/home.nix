  { self, inputs, ... }: {
   

 # ====== Nexus Home-Mananger Configuration ====== #
   flake.homeModules.nathHome = { config, pkgs, pkgs-unstable, ... }:
     
 {  
     imports = [
 #      self.homeModules.nexusHyprland
 #      self.homeModules.nexusNoctalia
 #      self.homeModules.dotfiles
     ];

     home = { 
       stateVersion = "24.05";
       username = "nath";
       homeDirectory = "/home/nath";
     };


    # ====== Allow Unfree ======
    nixpkgs.config.allowUnfreePredicate = _: true;
    
 
    # ====== Git ======
    programs.git = {
      enable = true;
      settings.user = {
        name = "NathBox";
        email = "nathbox@protonmail.com";
      };
    };
    
    
    # ====== Jujutsu ======
    programs.jujutsu = {
      enable = true;
      settings.user = {
          email = "nathbox@protonmail.com";
          name = "Nath";
      };
    };
     

    # ====== User Level Packages ======
    #home.packages = 
    # (with pkgs; [
    #])


    #++

    #(with pkgs-unstable; [
    #]);


    # ====== Automount Drives ====== 
    services.udiskie = {
      enable = true;
      automount = true;
      settings = {
        program_options = {
    #        # replace with your favorite file manager
            file_manager = "${pkgs.thunar}/bin/thunar";
        };
      };
    };    

 
    # GTK Setups
    #gtk = {
    #  enable = true;
    #  theme = {
    #    package = pkgs.flat-remix-gtk;
    #    name = "Flat-Remix-GTK-Grey-Darkest";
    #  };
    #};


    # ====== Bash ======  
     programs.bash = {
        enable = true;
        enableCompletion = true;
        profileExtra = ''
          #if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
          #  exec Hyprland
          #fi
        '';
        initExtra = ''
          fastfetch
          if [ -f $HOME/.bashrc-personal ]; then
            source $HOME/.bashrc-personal
          fi
        '';
        shellAliases = {
         update = "nh os switch --update /home/nath/NathOS/";
         rebuild = "nh os switch /home/nath/NathOS/";
         home = "nh home switch /home/nath/NathOS/";
         ls = "eza --icons"; 
        };
      };


    # ====== Create XDG Dirs ======
      xdg = {
        userDirs = {
         setSessionVariables = false;
         enable = true;
          createDirectories = false;
        };
      };  


    # ====== XDG Desktop Entries ====== #
    #xdg.desktopEntries = {
    #   fallout-ce = {
    #     name = "Fallout Community Edition";
    #     genericName = "Video Game";
    #     exec = "fallout-ce";
    #     terminal = false;
    #     categories = [ "Application" "Game" ];
    #     icon = "/home/nath/.local/share/fallout-ce/fallout.ico";
    #   };
    #};   
 
    # Steam Proton GE Setup
     home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/nath/.steam/root/compatabilitytools.d";
     };


    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
