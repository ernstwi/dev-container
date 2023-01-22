# dev-container

Docker image containing my personal development kit.

OS: Ubunty 22.04 (Jammy)  
Editor: Neovim

Requirements:
- GNU tar (`brew install gnu-tar`)

## Install

Define env vars:

- `DOTFILES`: Dotfiles repo
- `NVIM_CONFIG`: Neovim config repo
- `NVIM_PLUGINS`: Neovim package repo

```
./build   # Build docker image
./install # Install devc (symlink to /usr/local/bin)
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
