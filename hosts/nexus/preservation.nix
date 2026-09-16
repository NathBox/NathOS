{ self, inputs, ... }: {
 
  # ====== Preservation ======
  flake.nixosModules.nexusPreservation = { config, ... }: {
   
    # machineid error
    systemd.services.systemd-machine-id-commit = {
      unitConfig.ConditionPathIsMountPoint = [ "" "/persistant/etc/machine-id" ];
      serviceConfig.ExecStart = [ "" "systemd-machine-id-setup --commit --root /persistant" ];
    };

    boot.tmp.cleanOnBoot = true;

    preservation = {
      enable = true;

       preserveAt."/persistent" = {
         directories = [
           "/etc/nixos"
           "/var/lib/bluetooth"
           "/var/log"
          # "/tmp"
          #  "/home"
           {
           directory = "/var/lib/nixos";
           inInitrd = true;
           }
         ];

         files = [
           { file = "/etc/machine-id"; inInitrd = true; }
        #  "/etc/passwd" 
        #  "/etc/shadow"
         ];

      # Preserve user files
       users.nath = {
         commonMountOptions = [
           "x-gvfs-hide"
         ];
         
         directories = [
         "NathOS"
         "Pictures"
         "Videos"
         "Music"
         "Documents"
         "Downloads"
         "Games"
         "Scripts"
         "Coding"
         "Voice"
         "Servers"
         "Standalone Programs"
         "YouTube"
         ".steam"
         ".local/share"
         ".local/state/wireplumber"
         ".wine"
         ".config"
         ".cache/noctalia"
         ".cache/noctalia-qs"
         ".icons"
         ".ssh"
        # ".bitcoin"
        # ".bitmonero"
         ];
      
        files = [
          #".config/unity3d" 
       ];
     };
       };
    };
  };
}
