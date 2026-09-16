{ self, inputs, ... }: {

 
  # ====== System Nexus Declaration ====== #
  flake.nixosConfigurations.nexus = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.nexusConfig ];
  }; 

 
  # ====== System Nexus Configuration ====== # 
  flake.nixosModules.nexusConfig = { pkgs, pkgs-unstable, lib, ...}: {
    imports = [
      self.nixosModules.nexusHardware
      self.nixosModules.nexusNetwork
      self.nixosModules.nexusPackages
      self.nixosModules.nexusGaming
      self.nixosModules.nexusDisko
      self.nixosModules.nexusPreservation
      self.nixosModules.systemd
      self.nixosModules.timezone
      self.nixosModules.unstable
      self.nixosModules.fonts
      self.nixosModules.sddm
      self.nixosModules.hyprland
      self.nixosModules.noctalia
      self.nixosModules.mullvad
#      self.nixosModules.spotify        
     #self.nixosModules.memlock
      self.nixosModules.obs
      self.nixosModules.xdg
      self.nixosModules.udev
     # self.nixosModules.vm
      inputs.home-manager.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default
   
 ]; 

  # ====== Kernel ====== 
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen; # Zen Kernel for Gaming
    kernelParams = [ 
#      "quiet" # Disables Systemd Load screen for faster boot
    ];
  };


    # ====== SystemD ====== 
    services.journald.extraConfig = "SystemMaxUse=50M";
    #systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];


    # ====== CPU Scheduler ======
    services.scx = {
      enable = true;
      scheduler = "scx_lavd"; # specifices the scheduler package
    };


    # ====== Disk Utlites ======
    services = {
      gvfs.enable = true; 
      udisks2.enable = true;
      usbmuxd.enable = true;
    #  dbus.enable = true;
      fstrim = {
        enable = true;
        interval = "weekly";
      };
    };
   
    
   # ====== Thunar ====== 
   programs.thunar = {
     enable = true;
     plugins = with pkgs; [
       thunar-volman
       thunar-archive-plugin
       thunar-media-tags-plugin
     ];
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
        rocmPackages.clr.icd # This is for Davinvi Resolve
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
      initialPassword = "Zekrom33104M085@";
      extraGroups = [ "wheel" "input" "networkmanager" ]; 
    };
    users.mutableUsers = true;


    # ====== Home-Manager User ====== #
    home-manager = {
      users.nath = self.homeModules.nathHome;
      useUserPackages = true;
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


    # ====== OpenSSH ======
    services.openssh.enable = true;
    

    # ====== Allow Non Free Software ======
    nixpkgs.config.allowUnfree = true;


    # ====== System State Version (Do Not Change) ======
    system.stateVersion = "24.05"; # Did you read the comment?


    # ====== Experimental Features ======
    nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
    };
}

