{ self, inputs, ... }: {
 
  # ====== System Nexus Declaration ====== #
  flake.nixosConfigurations.nexus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.nexusConfig
    ];
  }; 

 
  # ====== System Nexus Configuration ====== # 
  flake.nixosModules.nexusConfig = { pkgs, pkgs-unstable, lib, ...}: {
    imports = [
      self.nixosModules.nexusHardware
      self.nixosModules.nexusNetwork
      self.nixosModules.vm
      self.nixosModules.hyprland
      self.nixosModules.noctalia
      self.nixosModules.spotify        
      #self.nixosModules.memlock
      self.nixosModules.unstable
      self.nixosModules.obs
      self.nixosModules.timezone
      self.nixosModules.xdg
      self.nixosModules.gaming
      #self.nixosModules.myHomeManager
      inputs.home-manager.nixosModules.default
    ]; 


  # ====== Kernel ====== #
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen; # Zen Kernel for Gaming
    kernelParams = [ 
      "quiet" # Disables Systemd Load screen for faster boot
    ];
  };


  # ====== SystemD ====== #
  boot = {
    loader = { 
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    }; 
  }; 
    
    services.journald.extraConfig = "SystemMaxUse=50M";
   # systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];


    # ====== CPU Scheduler ======
    services.scx = {
      enable = true;
      scheduler = "scx_lavd"; # specifices the scheduler package
    };


    # ====== Disk Utlites ======
    services = {
      devmon.enable = true;
      gvfs.enable = true; 
      udisks2.enable = true;
      usbmuxd.enable = true;
      fstrim = {
        enable = true;
        interval = "weekly";
      };
    };

    
    # ====== Audio ====== #
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
    security.rtkit.enable = true;


    # ====== AMD GPU Drivers ====== #
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      package = pkgs-unstable.mesa;
      extraPackages = with pkgs; [
      #  rocmPackages.clr.icd # This is for Davinvi Resolve
      ];
    };

    services.xserver.videoDrivers = ["amdgpu"];


    # ====== Bluetooth ======
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;


    # ====== Printing ======
    services.printing.enable = false;


    # ====== Nexus Users ====== #
    users.users.nath = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "networkmanager" ]; 
    };


    # ====== Home-Manager User ====== #
    home-manager = {
      users.nath = self.homeModules.nathHome;
      useUserPackages = true;
    };


   # ====== SDDM ====== #
   services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
     theme = "pkgs.sddm-chili-theme";
   };


    # ====== Environment Variables ======
    environment = {
      sessionVariables = {
        WLR_HARDWARE_CURSORS = "1";
      };
    };


    # ====== Nix Helper ======
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 4";
      };
      flake = "/home/nath/NathOS";
    };


    # ====== Mullvad Service ======
    services.mullvad-vpn.enable = true;


    # ====== OpenSSH ======
    # services.openssh.enable = true;
    

    # ====== Allow Non Free Software ======
    nixpkgs.config.allowUnfree = true;


    # ====== Package Build Fail Workarounds ======
    documentation.doc.enable = false;


    # ====== System Level Packages ======
    environment.systemPackages = (with pkgs; [
      wget
      curl
      appimage-run
      wineWow64Packages.waylandFull
      winetricks
      libimobiledevice
      #Cli Tools and Terminals
      fastfetch
      alacritty
      cool-retro-term
      eza
      vim
      unzip
      unrar
      zip
      fd
      #asciiquarium
      btop
      caligula # etcher alternative
      yt-dlp
      #wev
      #steamcmd
      nix-index
      comma
      ffmpeg_6
      #vkbasalt
      xremap
      brightnessctl

      #Wayland and Hyprland
      grim
      slurp
      adwaita-icon-theme
      wl-clipboard
      hyprcursor
      qimgv
      noctalia-shell

      #Disk Stuff
      nemo-with-extensions
      file-roller
      kdePackages.filelight

      #Media
      mpv
      vlc
      gimp3
      qbittorrent
      audacity
     # ardour
      subtitleedit
      freetube
      #jellyfin-media-player
      #jellyfin-mpv-shim

      # Social Media
      #signal-desktop

      #Audio and Bluetooth
      pavucontrol
      bluez
      bluez-tools

      obsidian
      monero-gui
      bitcoin
      libreoffice
      anki-bin
      ifuse

      #web
      #ungoogled-chromium
     # librewolf

      #Printing
      #gtklp
      #system-config-printer
      #docker

      # ====== AI Shit ======
      #lmstudio
      #kdePackages.kdenlive
      python312
      python312Packages.pip
      openai-whisper
      vesktop
      screen
      inputs.helium.packages.${system}.default
    ])

    ++

    (with pkgs-unstable; [
    ]);
  
    # ====== Fonts ======
    fonts = {
      packages = with pkgs; [
        nerd-fonts.fira-code
        font-awesome
        jetbrains-mono
        liberation_ttf
        material-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        #symbola
      ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    };
   

    # ====== System State Version (Do Not Change) ======
    system.stateVersion = "24.05"; # Did you read the comment?


    # ====== Experimental Features ======
    nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
    };
}

