# dotfiles

Shell, tmux, nvim and git config for my Linux machines (home servers and WSL), managed with [chezmoi](https://www.chezmoi.io/).

## New machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply albyp
```

This installs chezmoi, clones this repo, asks for your git name and email once (kept in `~/.config/chezmoi/chezmoi.toml`, never committed), installs the packages listed in `run_onchange_before_10-install-packages.sh.tmpl`, and writes the files. Then switch to zsh:

```sh
chsh -s "$(command -v zsh)"
```

## Day to day

| Task | Command |
|---|---|
| Edit a managed file and apply it | `chezmoi edit --apply ~/.zshrc` (or the shortcuts below) |
| See what would change | `chezmoi diff` |
| Pull changes from GitHub and apply | `chezmoi update` |
| Go to this repo | `chezmoi cd` |

## Helpers

| Command | What it does |
|---|---|
| `dotcheck` | Is this machine in sync? Shows managed files not applied, repo changes not committed or pushed, and new configs in `~` / `~/.config` that aren't managed yet. |
| `dotadd <file>` | Start managing a config. Refuses paths and contents that look like secrets (keys, tokens, logins), since this repo is public. `--force` if it's a false alarm. |
| `dotup` | `chezmoi update`: pull from GitHub and apply. |
| `dotdiff` | `chezmoi diff`: what `chezmoi apply` would change. |
| `dotcd` | `chezmoi cd`: a shell inside this repo (`exit` to return). |

`chezmoi add` and `chezmoi edit` commit and push by themselves (`autoCommit`, `autoPush` in `.chezmoi.toml.tmpl`). Things dotcheck should never suggest (logins, app state) are listed in `~/.config/shell/dotcheck-ignore` (edit with `ebi`).

## What's in it

| File | Purpose |
|---|---|
| `~/.zshrc` | zsh: case-insensitive menu completion, autosuggestions, syntax highlighting, shared history, starship prompt |
| `~/.bashrc` | bash, kept as a fallback; same aliases and bookmarks |
| `~/.config/shell/aliasrc` | aliases shared by both shells |
| `~/.config/shell/bm-dirs` | directory bookmarks: `dl` jumps to `~/Downloads`; in zsh `~dl` works anywhere (`mv file ~dl`) |
| `~/.config/shell/bm-files` | file bookmarks: `eba` edits the aliases, `ezrc` the zshrc, ... |
| `~/.config/tmux/tmux.conf` | tmux |
| `~/.config/nvim/` | neovim with lazy.nvim (plugin versions pinned in `lazy-lock.json`) |
| `~/.gitconfig`, `~/.config/git/ignore` | git, using `gh` for GitHub credentials (no plaintext token file), and a global ignore list |
| `~/.config/starship.toml` | the starship prompt |
| `~/.local/bin/dotcheck`, `dotadd` | the helpers above |

Bookmarks follow [Luke Smith's voidrice](https://github.com/LukeSmithxyz/voidrice) idea: one line per bookmark (`dl ~/Downloads`), and every shell picks it up. A bookmark whose path doesn't exist on a machine is skipped there.

## Rules

- No secrets, hostnames or IP addresses in this repo. Machine-specific values go in `~/.config/chezmoi/chezmoi.toml`.
- Shell history is never tracked.
