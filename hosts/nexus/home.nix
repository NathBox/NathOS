  { self, inputs, ... }: {
   

 # ====== Home-Mananger Configuration ====== #
   flake.homeModules.nathHome = { pkgs, pkgs-unstable, fluxer-nix, ... }: {  

     home.stateVersion = "24.05";
     home.username = "nath";
     home.homeDirectory = "/home/nath";


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


    # ====== User Level Packages ======
    home.packages = 
     (with pkgs; [
    ])


    ++

    (with pkgs-unstable; [
    ]);


  # ====== Allow Insecure Packages ====== 
  #nixpkgs.config.permittedInsecurePackages = ["qtwebengine-5.15.19"];


    # ====== Automount Drives ====== 
    #services.udiskie = {
    #  enable = true;
    #  settings = {
    #    program_options = {
    #        # replace with your favorite file manager
    #        file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
    #    };
    #  };
    #};    


 
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

  # Create XDG Dirs
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };  

    # ====== Home File Placement ====== # 
      home.file = {
        ".config/fastfetch" = {
          source = ./fastfetch;
          recursive = true;
        };
        ".local/share/icons/NotwaitaBlack" = {
          source = ./icons/NotwaitaBlack;
          recursive = true;
        };
        ".local/share/fonts" = {
          source = ./fonts;
          recursive = true;
        };
     };
 
    # ====== XDG Desktop Entries ====== #
    xdg.desktopEntries = {
       fallout-ce = {
         name = "Fallout Community Edition";
         genericName = "Video Game";
         exec = "fallout-ce";
         terminal = false;
         categories = [ "Application" "Game" ];
         icon = "/home/nath/.local/share/fallout-ce/fallout.ico";
       };
    };   

 
    # Steam Proton GE Setup
     home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "/home/nath/.steam/root/compatabilitytools.d";
     };

    # Home Manager can also manage your environment variables
     home.sessionVariables = {
      # EDITOR = "emacs";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
