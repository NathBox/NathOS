{ self, inputs, ... }: {

  flake.nixosModules.nexusNetwork = { config, pkgs, ... }: {
   
    # ====== Nexus Networking ====== #
    networking = {
      hostName = "nexus";
      networkmanager.enable = false;
      dhcpcd.enable = false;
      nameservers = ["185.228.168.9" "185.228.169.9"]; # DNS Server Config

      interfaces.enp6s0 = {
        ipv4.addresses = [{
          address = "192.168.0.15"; #.45
          prefixLength = 24;
         }];
       };
       defaultGateway = {
         address = "192.168.0.1";
         interface = "enp6s0";
       };
       firewall = {
         enable = true;
         allowedTCPPorts = [ 80 443 7777 ]; # 2456 2457 2458 for Valheim and 7777 for terraria
         allowedUDPPorts = [ 7777 ];
       };
     };
 };
}
