# Neovim on Nix

## Motivation and Goals

- keep easiness and dynamic nature of neovim
  - install plugins and LSP servers with nix
  - configure with .lua
  - Iterate on lua config without nix rebuild. Just restart neovim

- nixCats-nvim is more customizable
- Kickstart-nix.nvim is simpler then nixCats-nvim
- neovim-nix does it's best to be even simpler

## Features

Changes in nvim config are both instant and tracked by git.

- tweak the config as easy and fast as without nix
- run the same config as any user and on any machine with nix
- edit your config directory as if it were a `~/.config/nvim/`. Config is loaded only from the provided config directory. And from nowhere else.

### Why not just Home Manager's Neovim?

First. HM makes only one neovim package. But with nvim-on-nix you can have any number of neovims:
- one picks up nvim config changes rigth away, so that you easy iterate on config
- one uses config saved in nix store, so you have a working nvim even when nvim directory is messed up in a crazy configuration jorney
- one to use as a `$MANPAGER`. Start instantly by saving on features

## Gotchas and Rough Edges

1. To setup the mutable config, you need to provide an absolute path for the symlink, and to run a shell script. See `Install and Start` section

2. Here are no tools to convert from non-nix (probably Lazy-based) neovim config

## Install and Start

### Bootstrap
1. Bootstrap the repository from the template
To bootstrap the symlink:
1. edit `./configLink.nix`
2. run `./scripts/bootstrapMutableConfig.sh`

### Run
1. `nix run `

## Anatomy

- `./nvim/` - behaves exactly as `~/.config/nvim/`
; # TODO fix the name
- `overlay.nix` - Describe your neovim packages. What plugins and extra programs to install
- `mkNeovim.nix` - function which makes a neovim derivation

## Converting From non-nix

I believe, it's the most complex task with this template.

1. update list of plugins in `overlay.nix`
2. put your `nvim` config directory in place of `./nvim`

### :zap: Optimise Startup Time

#### Profile

https://github.com/folke/snacks.nvim/blob/main/docs/profiler.md#profiling-neovim-startup

To profile startup time, run your `nvim` with `PROF=1`
```sh
PROF=1 nvim
```

#### Lazy-load Plugins

Look at `lze` or `lz.n` plugins.

#### Pick Treesitter Grammars

### Develop Plugins

1. Make a directory with plugins you develop
2. organize them as a package: `pack/{}/start/{}` or `pack/{}/opt/{}`
3. add the directory to `packpath` in `init.lua`: `vim.opt.packpath:append('~/PACK-DIR')`

I haven't ever done it myself :D

### `plugin/` vs `require()`
One can choose how to manage files `neovim` loads for you. You can either put files
in the `plugin/` directory or `require()` them from `init.lua`.

Files in `plugin/` are loaded automatically; just put the file, and vim will load it.

### TODO

- TODO: make templates
- TODO: homeModule
- TODO: test oos link with nix --impure and default package
- TODO: decouple package definitions from overlay

