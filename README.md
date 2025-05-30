## Disclaimer

This repo contains the latest and greatest version of my dotfiles.
I try to extract meaningful bits and pieces to separate plugins/repositories so they can be used by the broader public, however tweaks that are highly personal preference often first end up here before I decide what to do with them.

In summary my work environment consists of:

| purpose | tool |
|---------|------|
| editor | Neovim |
| terminal multiplexer | Tmux |
| shell | Zsh |
| terminal application | Alacritty |

![image](https://raw.githubusercontent.com/alexanderjeurissen/dotfiles/main/_assets/screenshots/nord.png)

## Installation

### Using rcm

1. Install `rcm` using your package manager, e.g. `brew install rcm`.
2. Clone this repository into `~/.dotfiles`.
3. Run `rcup -v` from the repo root to symlink all managed files. The
   included `rcrc` file controls which files are linked.

### Manual setup

Create your own symlinks if you prefer not to use `rcm`:

```sh
ln -s "$PWD/zshrc" ~/.zshrc
ln -s "$PWD/tmux.conf" ~/.tmux.conf
```

### Dependencies

- **Homebrew** packages: `brew bundle` installs everything from the
  `Brewfile`.
- **Yarn** packages: run `npx yarn-bundle` to install entries from
  `Yarnfile`.
- **Cargo** packages: `cargo install --locked $(awk '{print $1}' CargoFile)`.

### Editor and shell configuration

- Neovim uses the files under `config/nvim`. Start Neovim once to install
  plugins.
- Zsh is configured using `zshrc`, `zshenv` and related files. Set it as
  your shell with `chsh -s $(which zsh)`.
- Additional application configs live in the `config/` directory (for
  Ranger, etc.). Link them with `rcup` or create
  manual symlinks.

### Terminfo entries

Custom terminfo definitions live in the `terminfo/` directory. Compile and
install them using:

```sh
scripts/install-terminfo.sh
```

This installs the entries into `~/.terminfo` so that tools like tmux can use
them.

### Tmux plugins

Clone the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) and
install the configured plugins by running:

```sh
scripts/install-tmux-plugins.sh
```

Run this once after linking `tmux.conf`.

### Compiling Zsh files

Run `scripts/compile-zsh` whenever you modify `zsh_prompt`, `zsh_aliases` or
`zsh_keybindings` to regenerate their `.zwc` files. The compiled versions will
be loaded automatically if present.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
