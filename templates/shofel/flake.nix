{
  # @see an intro to flakes:
  #   https://vtimofeenko.com/posts/practical-nix-flake-anatomy-a-guided-tour-of-flake.nix

  description = "Shovel's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Vim plugins from outside the nixpkgs
    vim-kitty = {url = "github:fladson/vim-kitty"; flake = false; };
    neoclip.url = "github:neoclip-nvim/neoclip-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];
  in {
    packages = forAllSystems (system:
      let overlay = (import ./neovim.nix {inherit inputs;});
          x = nixpkgs.legacyPackages.${system}.extend overlay;
      in {
        nvim-sealed = x.nvim-shovel-sealed;
        nvim-mutable = x.nvim-shovel-mutable;
        neorg = x.nvim-shovel-neorg;
        default = x.nvim-shovel-mutable;
      });
  };
}
