{ self, inputs, ... }: {

 
  # ====== System Nexus Declaration ====== #
  flake.nixosConfigurations.vinland = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.vinlandConfig ];
  }; 

 
  # ====== System Nexus Configuration ====== # 
  flake.nixosModules.vinlandConfig = { pkgs, pkgs-unstable, lib, ...}: {
    imports = [
      self.nixosModules.vinlandHardware
      self.nixosModules.vinlandPackages
      self.nixosModules.vinlandGaming
      self.nixosModules.vinlandDisko
      self.nixosModules.vinlandPreservation
      self.nixosModules.systemd
      self.nixosModules.timezone
      self.nixosModules.unstable
      self.nixosModules.fonts
      self.nixosModules.sddm
      self.nixosModules.hyprland
      self.nixosModules.noctalia
      self.nixosModules.mullvad
     # self.nixosModules.spotify        
      #self.nixosModules.obs
      self.nixosModules.xdg
     # self.nixosModules.vm
      inputs.home-manager.nixosModules.default
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default
   
 ]; 

  # ====== Kernel ====== 
  boot = {
    #kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_zen; # Zen Kernel for Gaming
    kernelParams = [ 
#      "quiet" # Disables Systemd Load screen for faster boot
    ];
  };


    # ====== SystemD ====== 
    services.journald.extraConfig = "SystemMaxUse=50M";
    systemd.services.NetworkManager-wait-online.wantedBy = lib.mkForce [];

    # ====== Networking ======
    networking = {
      networkmanager.enable = true;
      hostName = "vinland";
      nameservers = ["185.228.168.9" "185.228.169.9"];
      firewall = {
        enable = true;
        allowedTCPPorts = [ 80 443 ];
      };
    };
 
    # ====== CPU Scheduler ======
    services.scx = {
      enable = false;
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
    
    # ====== Power ======
    services.upower = {
      enable = true;
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
       # rocmPackages.clr.icd # This is for Davinvi Resolve
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
      users.nath = self.homeModules.vinlandHome;
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

