# dev-container

Docker image containing my personal development kit.

OS: Ubunty 22.04 (Jammy)  
Editor: Neovim  
Tools: git, fzf, curl, fd, z

Requirements:
- GNU tar (`brew install gnu-tar`)
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

Run bash in a new container `foo` with bind mount `~/devc/foo:~/foo`.

`devc --init foo bar`

Run bash in a new container `foo` with bind mount `~/devc/bar:~/bar`.

`devc foo`

Resume stopped container `foo`.
