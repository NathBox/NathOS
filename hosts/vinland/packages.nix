{ self, inputs, ... }: {
  
  # ====== System Vinland Packages ======
  flake.nixosModules.vinlandPackages = { config, pkgs, pkgs-unstable, ... }: {
    environment.systemPackages = (with pkgs; [
      wget
      git
      curl
      appimage-run
      wineWow64Packages.waylandFull
      winetricks
      stow
     # libimobiledevice

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
      runapp
      #asciiquarium
      btop
      caligula # etcher alternative
      yt-dlp
      #wev
      #steamcmd
      #nix-index
      #comma
     # ffmpeg_6
      #vkbasalt
      #xremap

      #Wayland and Hyprland
      grim
      slurp
      adwaita-icon-theme
      #wl-clipboard
      hyprcursor
      qimgv

      #Disk Stuff
      thunar
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
      file-roller
      kdePackages.filelight

      #Media
      mpv
     # vlc
      gimp3
      #qbittorrent
      #audacity
     # ardour
      #subtitleedit
      #freetube
      pear-desktop
      #jellyfin-media-player
      #jellyfin-mpv-shim

      # Social Media
      #signal-desktop

      #Audio and Bluetooth
      pavucontrol
      bluez
      bluez-tools

      obsidian
     # monero-gui
     # bitcoin
      libreoffice
      #anki-bin
      #ifuse

      #web
      #ungoogled-chromium

      #Printing
      #gtklp
      #system-config-printer
      #docker
      # ====== AI Shit ======
      #lmstudio
      #kdePackages.kdenlive
      python312
      python312Packages.pip
      #openai-whisper
      #vesktop
      screen
      inputs.helium.packages.${stdenv.hostPlatform.system}.default
      #davinci-resolve-studio
      mullvad-vpn
#      quartus-prime-lite
    ])

    ++

    (with pkgs-unstable; [
    #mullvad-vpn
    quartus-prime-lite
    ]);

    # ====== Package Build Fail Workarounds ======
    documentation.doc.enable = false;

  };
}
