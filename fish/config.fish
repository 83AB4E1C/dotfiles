if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias ll "exa --icons -al"
alias ls "exa --icons"
alias rc "source ~/.config/fish/config.fish"
alias vp "set -gx http_proxy http://192.168.0.110:7890;set -gx https_proxy http://192.168.0.110:7890"
alias up "set -gx http_proxy '';set -gx https_proxy ''"
alias vi "nvim"

set -gx PATH $HOME/.local/share/nvim/lsp_home/lua-language-server/bin $PATH
set -gx PATH $HOME/.local/share/nvim/lsp_home/rust-language-server $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx RUSTUP_DIST_SERVER https://mirrors.ustc.edu.cn/rust-static
set -gx RUSTUP_UPDATE_ROOT https://mirrors.ustc.edu.cn/rust-static/rustup
