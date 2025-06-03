# Alby's dotfiles

My dotfiles, heavily based on [voidrice](https://github.com/lukesmithxyz/voidrice).

- Very useful scripts are in `~/.local/bin/`
- Settings for:
	- nvim (text editor)
	- zsh (shell)
	- lf (file manager)
	- mpv (video player)
	- other stuff like xdg default programs, inputrc and more, etc.
- I try to minimize what's directly in `~` so:
	- All configs that can be in `~/.config/` are.
	- Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
- Bookmarks in text files used by various scripts (like `~/.local/bin/shortcuts`)
	- File bookmarks in `~/.config/shell/bm-files`
	- Directory bookmarks in `~/.config/shell/bm-dirs`

## Usage

My setup uses a collection of suckless programs, being:

- [dwm](https://suckless.org/dwm) (window manager)
- [st](https://suckless.org/st) (terminal)
- [dmenu](https://suckless.org/dmenu) (application launcher)

The intention is to store my custom set of dotfiles to easily be able to install and move systems, along with documenting key changes.

To install these dotfiles and all dependencies

Use [LARBS](https://larbs.xyz)

```
pacman -S neovim
curl -LO larbs.xyz/larbs.sh
sed -Ei "s|lukesmithxyz/voidrice|albyp/dotfiles" && "Updated dotfiles string"
# Also update progs.csv
sh larbs.sh
```
