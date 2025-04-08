{
  # @see an intro to flakes:
  #   https://vtimofeenko.com/posts/practical-nix-flake-anatomy-a-guided-tour-of-flake.nix

  description = "Neovim on Nix template";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];
  in {
    packages = forAllSystems (system:
      let overlay = (import ./neovim.nix {inherit inputs;});
          x = nixpkgs.legacyPackages.${system}.extend overlay;
      in {
        default = x.nvim-on-nix;
      });
  };
}
