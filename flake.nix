{
  description = "Neovim on Nix";

  inputs = {
  };

  outputs = inputs: {

    templates.shofel = {
      path = ./templates/shofel;
      description = "Shofel's neovim packages";
    };

    templates.empty = {
      path = ./templates/empty;
      description = "Empty neovim on nix template";
    };
  };
}
