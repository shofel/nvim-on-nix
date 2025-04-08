{
  description = "Neovim on Nix";

  inputs = {
  };

  outputs = inputs: {

    templates.shofel = {
      path = ./templates/shofel;
      description = "Shofel's neovim packages";
    };
  };
}
