# dev-container

Docker image containing my personal development kit.

OS: Ubunty 22.04 (Jammy)  
Editor: Neovim  
Tools: git, fzf, curl, fd, z

Requirements:
- GNU tar (`brew install gnu-tar`)
- Go (for `devc` completion)
- Dotfiles repo: `~/dotfiles`
- Neovim config repo: `~/.config/nvim`
- Neovim package repo: `~/.local/share/nvim/site/pack/all`

## Install

```
./build   # Build docker image
./install # Install devc + completion
```

## Usage

```
devc [--init [<host port> [<container port>]]]
```

`devc --init`

Run bash in a new container with cwd mounted. Overwite existing container for this directory.

`devc`

Resume an existing container associated with cwd. If none exists, same as `devc --init`.

`devc --init 1000`

Run bash in a new container with cwd mounted, port forward `1000:1000`.

`devc --init 1000 2000`

Run bash in a new container with cwd mounted, port forward `1000:2000`.
