#! /usr/bin/bash
#set -e

symbol_link() {
  rm -rf $2
  ln -sf $1 $2
}

lsp_install() {
  sudo npm i -g pyright
  sudo npm i -g vscode-langservers-extracted
  sudo npm i -g typescript typescript-language-server
  sudo npm i -g dockerfile-language-server-nodejs
  sudo npm i -g bash-language-server
  go install golang.org/x/tools/gopls@latest
  lsp_home=$HOME/.local/share/nvim/lsp_home
  [[ -d $lsp_home ]] && rm -rf $lsp_home
  mkdir -p $lsp_home

  lua_lsp_home=$lsp_home/lua-language-server
  mkdir -p $lua_lsp_home
  lua_lsp_tag=$(curl -s https://api.github.com/repos/LuaLS/lua-language-server/releases/latest | jq -r '.tag_name')
  curl -fL https://github.com/LuaLS/lua-language-server/releases/download/$lua_lsp_tag/lua-language-server-$lua_lsp_tag-linux-x64.tar.gz -o $lua_lsp_home/lua-language-server.tar.gz
  tar -xf $lua_lsp_home/lua-language-server.tar.gz -C $lua_lsp_home
  rm -rf $lua_lsp_home/lua-language-server.tar.gz

  rust_lsp_tag=$(curl -s https://api.github.com/repos/rust-lang/rust-analyzer/releases/latest | jq -r '.tag_name')
  rust_lsp_home=$lsp_home/rust-language-server
  mkdir -p $rust_lsp_home
  curl -fL https://github.com/rust-lang/rust-analyzer/releases/download/$rust_lsp_tag/rust-analyzer-x86_64-unknown-linux-gnu.gz -o $rust_lsp_home/rust-analyzer.gz
  gzip -d $rust_lsp_home/rust-analyzer.gz
  chmod +x $rust_lsp_home/rust-analyzer
}

prepare() {
  if [[ -d "/usr/local/bin/oh-my-posh" ]]; then
    exit 1
  fi
  sudo cp -r ~/.dotfiles/fonts/* /usr/share/fonts
  sudo fc-cache
  sudo apt update && sudo apt upgrade
  sudo apt install -y fish golang nodejs npm python3-pip wget curl unzip clangd jq fcitx5 fcitx5-rime alsa-util alsamixer i3 i3blocks
  curl -fLO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
  sudo apt install ./nvim-linux64.deb
  sudo chsh -s /usr/bin/fish md

  npm config set registry https://mirrors.huaweicloud.com/repository/npm/
  sudo npm config set registry https://mirrors.huaweicloud.com/repository/npm/
  pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
  sudo pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
  go env -w GO111MODULE=on
  go env -w GOPROXY=https://goproxy.cn,direct
  sudo go env -w GO111MODULE=on
  sudo go env -w GOPROXY=https://goproxy.cn,direct
}

symbol_link $(pwd)/.vimrc ~/.vimrc
symbol_link $(pwd)/.tmux.conf ~/.tmux.conf
symbol_link $(pwd)/.gitconfig ~/.gitconfig
symbol_link $(pwd)/nvim ~/.config/nvim
symbol_link $(pwd)/wezterm ~/.config/wezterm
symbol_link $(pwd)/kitty ~/.config/kitty
symbol_link $(pwd)/fish ~/.config/fish
symbol_link $(pwd)/awesome ~/.config/awesome
symbol_link $(pwd)/i3 ~/.config/i3
symbol_link $(pwd)/.zshrc ~/.zsh
symbol_link $(pwd)/.p10k.zsh ~/.p10k.zsh

case $1 in
  "prepare")
    prepare
    ;;
  "lsp_install")
    prepare
    lsp_install
    ;;
  *)
    ;;
esac
