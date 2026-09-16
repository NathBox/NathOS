
# ====== Virtual Machine ====== #

{self, inputs, ...}: {

  flake.nixosModules.vm = { config, pkgs, ... }: {
 
  # Dconf (if needed)
  programs.dconf.enable = true;

  # Add user to libvirtd group
   users.users.nath.extraGroups = [ "libvirtd" ];
 
  # Virt Manager
   programs.virt-manager.enable = true;

  # Necessary Packages
   environment.systemPackages = with pkgs; [
    virt-viewer
    spice spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
];

  # Virt Services
   virtualisation = {
     libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
       # ovmf.enable = true;
       # ovmf.packages = [pkgs.OVMFFull.fd];
    };
   };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

 };
}
