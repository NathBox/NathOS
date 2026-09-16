{ self, inputs, ... }: {

  # ====== Global Dotfiles Symlink ======
  flake.homeModules.dotfiles = { config, pkgs, ... }:
  
  let
    globaldotsDir = "/home/nath/NathOS/global/dotfiles";
  in

{
    xdg.configFile = {
      #"alacritty" = {
      #  source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/alacritty";
      #};
      "fastfetch" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/fastfetch";
      };
      "net.imput.helium" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/net.imput.helium";
      };
      "fluxercanary" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/fluxercanary";
      };
      "mpv" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/mpv";
      };
      "obs-studio" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/obs-studio";
      };
      "obsidian" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/obsidian";
      };
      "spotify" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/config/spotify";
      };
    };  


    home.file = {
      ".icons" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/icons";
        force = true;
      };
      ".local/share/fonts" = {
        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/localshare/fonts";
        force = true;
      };
#      "Pictures/wallpapers" = {
#        source = config.lib.file.mkOutOfStoreSymlink "${globaldotsDir}/wallpapers";
#        force = true;
#      };
    };
  };
}
      
