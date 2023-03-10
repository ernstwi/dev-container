FROM ubuntu:jammy
WORKDIR /root

RUN apt update

# ---- Languages etc -----------------------------------------------------------

# Node
RUN curl -L https://deb.nodesource.com/setup_18.x | bash -
RUN apt install -y nodejs

# C
RUN apt install -y build-essential

# Go
RUN apt install -y golang

# Python
RUN apt install -y python3-pip

# ---- Misc tools --------------------------------------------------------------

# git, fzf, curl, ranger, bat
RUN apt install -y git
RUN apt install -y fzf
RUN apt install -y curl
RUN apt install -y ranger
RUN apt install -y bat

# nvr
RUN pip install neovim-remote

# tldr
RUN npm install -g tldr

# fd
RUN apt install -y fd-find
RUN ln -s $(which fdfind) /usr/local/bin/fd

# z
ADD https://raw.githubusercontent.com/rupa/z/master/z.sh /usr/local/etc/profile.d/z.sh

# ---- Neovim ------------------------------------------------------------------

# Neovim
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt install -y neovim

# LSP servers
RUN npm install -g typescript-language-server typescript
RUN npm install -g prettier
RUN apt install -y gopls

# Providers: Python, Node, Ruby
RUN pip install pynvim
RUN npm install -g neovim
RUN apt install -y ruby-dev
RUN gem install neovim

# Plugins
ADD nvim-plugins.tar .local/share/nvim/site/pack/all

# Treesitter (vim, lua, c are bundled with Neovim)
RUN nvim --headless -c "TSInstallSync javascript typescript go" -c "quit"

# Config
ADD nvim-config.tar .config/nvim

# ---- Dotfiles ----------------------------------------------------------------

ADD dotfiles.tar dotfiles
RUN echo 'export PS1="$PS1\[\e[32m\](docker)\[\e[m\] "' >> dotfiles/.bashrc
RUN rm .bashrc
WORKDIR /root/dotfiles
RUN ./symlink_create.sh
WORKDIR /root
