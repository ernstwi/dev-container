FROM ubuntu:jammy
WORKDIR /root

RUN apt update

# ---- Dotfiles ----------------------------------------------------------------

ADD dotfiles.tar dotfiles
RUN echo 'export PS1="$PS1\[\e[32m\](docker)\[\e[m\] "' >> dotfiles/.bashrc
RUN rm .bashrc
RUN dotfiles/symlink_create.sh

# ---- Misc tools --------------------------------------------------------------

# git, fzf, curl
RUN apt install -y git
RUN apt install -y fzf
RUN apt install -y curl

# fd
RUN apt install -y fd-find
RUN ln -s $(which fdfind) /usr/local/bin/fd

# z
ADD https://raw.githubusercontent.com/rupa/z/master/z.sh /usr/local/etc/profile.d/z.sh

# ---- Compilers, languages, runtimes ------------------------------------------

# Node
RUN curl -L https://deb.nodesource.com/setup_18.x | bash -
RUN apt install -y nodejs

# C
RUN apt install -y build-essential

# ---- Neovim ------------------------------------------------------------------

# Neovim
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt install -y neovim

# Neovim config
ADD nvim-config.tar .config/nvim
ADD nvim-plugins.tar .local/share/nvim/site/pack/all/start

# LSP servers
RUN npm install -g typescript-language-server typescript
RUN npm install -g prettier

# Treesitter
# (vim, lua, c are bundled with Neovim)
RUN nvim --headless -c "TSInstallSync javascript typescript" -c "quit"

# Providers: Python, Node, Ruby
RUN apt install -y python3-pip
RUN pip install pynvim
RUN npm install -g neovim
RUN apt install -y ruby-dev
RUN gem install neovim
