{ self, inputs, ... }: {

  # ====== Nexus Drive Configuration ======
  flake.nixosModules.vinlandDisko = { config, ... }: {
    
    fileSystems = {
      "/nix".neededForBoot = true;
      "/persistent".neededForBoot = true;
    };

    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%"
          "mode=755"
        ];
      };
    };

    disko.devices.disk.main = {
      device = "/dev/nvme0n1"; # MAKE SURE TOO SELECT CORRECT DISK HERE
      type = "disk";

      content.type = "gpt";

      content.partitions.boot = {
        name = "boot";
        size = "1M";
        type = "EF02";
      };

      content.partitions.esp = {
        name = "ESP";
        size = "1G";
        type = "EF00";

        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = [ "fmask=0077" "dmask=0077" ];
        };
      };

      content.partitions.swap = {
        size = "16G";

        content = {
          type = "swap";
          resumeDevice = true;
        };
      };

      content.partitions.root = {
        name = "root";
        size = "100%";

        content = {
          type = "btrfs";
          extraArgs = ["-f"];

          subvolumes = {
            "/persistent" = {
              mountOptions = ["subvol=persistent" "noatime"];
              mountpoint = "/persistent";
            };

            "/nix" = {
              mountOptions = ["subvol=nix" "noatime"];
              mountpoint = "/nix";
            };
          };
        };
      };
    };        
  };
}
