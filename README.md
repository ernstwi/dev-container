# dev-container

Docker image containing my personal development kit.

OS: Ubunty 22.04 (Jammy)  
Editor: Neovim  
Tools: git, fzf, curl, fd, z

Requirements:
- Dotfiles repo: `~/dotfiles`
- Neovim config repo: `~/.config/nvim`
- Neovim package repo: `~/.local/share/nvim/site/pack/all`

## Install

```
./build   # Build docker image
./install # Symlink devc to /usr/local/bin
```

## Usage

```
devc [--init] <name> [<mount>]
```

`devc --init foo`

Create a new container `foo`.

`devc --init foo bar`

Create a new container `foo` with a mount to `~/devc/bar` (created if nonexistent).

`devc foo`

Resume stopped container `foo`.
