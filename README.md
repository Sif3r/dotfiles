# <p align="center">Dotfiles</p>

This repository contains my personal dotfiles for various applications and shell configurations.
Dotfiles are configuration files that are used to personalize your system.
The `dotfiles` directory structure and customization scripts are optimized to work with
GNU Stow, a symlink farm manager that makes it easy to manage and organize dotfiles.

## Structure

The repository includes configurations for:
- Alacritty (a GPU-accelerated terminal emulator)
- i3 (a tiling window manager)
- Neovim (an extensible text editor)

Here is a breakdown of the main items:

- `.config/`
  - `alacritty/` - contains Alacritty terminal configurations.
  - `i3/` - contains configuration files for the i3 window manager.
  - `nvim/` - contains extensive Neovim configurations including Lua scripts for various editor functions.
- `.gdbinit` - configuration for GDB, the GNU Debugger.
- `.gitconfig` - Git configuration settings.
- `.tmux.conf` - Tmux terminal multiplexer configurations.
- `.zshrc` - Z shell configuration file.

## 🛠️ Installation
```bash
git clone https://your-repository-url.git
sudo pacman -S stow
cd dotfiles
stow .
```
