{ self, inputs, ... }: {

  # ====== Fonts =====
  flake.nixosModules.fonts = { config, pkgs, ... }: {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.fira-code
        font-awesome
        jetbrains-mono
        liberation_ttf
        material-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        #symbola
      ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
    };
  };
}
