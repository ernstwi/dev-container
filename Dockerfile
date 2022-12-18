FROM ubuntu:jammy
WORKDIR /root

RUN apt update

# Misc tools
RUN apt install -y git
RUN apt install -y fzf
RUN apt install -y curl
RUN apt install -y fd-find
RUN ln -s $(which fdfind) /usr/local/bin/fd

# Dotfiles
COPY dotfiles dotfiles
RUN rm .bashrc
RUN dotfiles/symlink_create.sh
RUN echo 'export PS1="$PS1\[\e[32m\](docker)\[\e[m\] "' >> .bashrc

# Neovim config + plugins
COPY start .local/share/nvim/site/pack/all/start
RUN rm .local/share/nvim/site/pack/all/start/nvim-treesitter/parser/*
COPY nvim .config/nvim

# z
ADD https://raw.githubusercontent.com/rupa/z/master/z.sh /usr/local/etc/profile.d/z.sh

# Node
RUN curl -L https://deb.nodesource.com/setup_18.x | bash -
RUN apt install -y nodejs

# Neovim
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable
RUN apt install -y neovim

# LSP servers
RUN npm install -g typescript-language-server typescript
RUN npm install -g prettier

# Treesitter
# vim, lua, c are bundled with nvim
RUN apt install -y build-essential
RUN nvim --headless -c "TSInstallSync! vim lua c typescript javascript" -c q

# Providers
RUN apt install -y python3-pip
RUN pip install pynvim
RUN npm install -g neovim
RUN apt install -y ruby
RUN gem install neovim
