{ self, inputs, ... }: {
  
  flake.nixosModules.udev = { config, pkgs, lib, ... }: {


    # ====== Udev ====== #
    services.udev = {
      packages = lib.singleton (pkgs.writeTextFile {
        name = "sayo";
        text = ''
          SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1d6b", TAG+="uaccess"
          SUBSYSTEM=="usb", ATTRS{idVendor}=="1d6b", TAG+="uaccess"
        '';
        destination = "/etc/udev/rules.d/70-sayo.rules";
      });
      extraRules = ''
        ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
     '';
    };
 };
}
