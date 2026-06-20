  { self, inputs, ... }: {

    # ====== OBS Studio ====== #

    flake.nixosModules.obs = { config, pkgs, pkgs-unstable, ... }: {
      programs.obs-studio = {
        enable = true;
        package = pkgs-unstable.obs-studio;
        plugins = with pkgs-unstable.obs-studio-plugins; [
          obs-tuna
          obs-3d-effect
          input-overlay
          obs-source-clone
          obs-shaderfilter
          obs-freeze-filter
          obs-composite-blur
          #obs-vertical-canvas
          obs-pipewire-audio-capture
          obs-multi-rtmp
        ];
      };
    };
  }
