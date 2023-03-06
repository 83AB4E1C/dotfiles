#
#:qa
#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

#  PROMPT='%B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k'
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# plugin
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/powerlevel10k/powerlevel10k.zsh-theme


# alias
alias ls="ls --color=auto"
alias ll="ls -lh --color=auto"
alias la="ls -Alh --color=auto"
alias rc="source ~/.zshrc"
alias vp "http_proxy=http://192.168.0.110:7890;https_proxy=http://192.168.0.110:7890"
alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias vi="nvim"

export EDITOR='vi'
# environment variable
lsp_rust="$HOME/.local/share/nvim/lsp_home/rust-language-server"
lsp_lua="$HOME/.local/share/nvim/lsp_home/lua-language-server/bin"
lsp_go="/home/mdd/go/bin"
lsp_zig="/usr/local/zig"
case ":${PATH}:" in
    *:"/usr/local/sumneko_lua/bin":*)
        ;;
    *)
        PATH="$lsp_lua:$lsp_rust:$lsp_go:$lsp_zig:$PATH"
        ;;
esac
.  "$HOME/.cargo/env"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
