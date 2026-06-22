  
  # ====== NathOS 2.0 ====== #

{
  description = "NathOS 2.0";

  inputs = {

     # ====== Nixpkgs Official Channels ====== #
     nixpkgs.url = "nixpkgs/nixos-26.05";
     nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    # nixpkgs-old.url = "nixpkgs/nixos-25.11";
    # nixpkgs-master.url = "nixpkgs/master";
     
     # ====== Dendritic ====== #
     flake-parts.url = "github:hercules-ci/flake-parts";
     import-tree.url= "github:vic/import-tree";

     # ====== Home-Manager ====== # 
     home-manager = {
       url = "github:nix-community/home-manager/release-26.05";
       inputs.nixpkgs.follows = "nixpkgs";
     };
       
     # ====== Additional Inputs ====== #
     #fluxer-nix.url = "github:ardishko/fluxer-nix";
     helium = {
       url = "github:AlvaroParker/helium-nix";
       inputs.nixpkgs.follows = "nixpkgs";
     };

     oskars-dotfiles = {
       url = "github:oskardotglobal/.dotfiles/nix";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  # ====== Variables ======
  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    # ====== Recursive Nix File Import ====== # 
    isNixModule = file:
      file.hasExt "nix"
      && file.name != "flake.nix"
      && !lib.hasPrefix "_" file.name;

    importTree = path:
      toList (fileFilter isNixModule path);

    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
   in
    mkFlake {imports = importTree ./.;}; 
}
