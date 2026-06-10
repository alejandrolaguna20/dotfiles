export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

setopt PROMPT_SUBST

precmd() {
  LAST_EXIT_CODE=$?
}

git_branch() {
  local branch
  branch=$(git branch --show-current 2>/dev/null)

  [[ -n $branch ]] && echo " %F{#96d8e3}git:(%f%F{#dfd286}${branch}%f%F{#cca6e7})%f"
}

exit_status() {
  echo "%F{#e3b096}${LAST_EXIT_CODE}%f "
}

PROMPT='$(exit_status)%F{#96bddf}%1~%f$(git_branch) %F{#eaa4c9}%%%f '

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias val='valgrind --leak-check=full --show-leak-kinds=all'
alias gdb='gdb -q'
alias v='nvim'
alias t='task'
alias mountusb='sudo mkdir /run/media/alex/M-O -p && sudo mount /dev/sda1 /run/media/alex/M-O && cd /run/media/alex/M-O'
alias yta='yt-dlp -x --audio-format mp3'

export EDITOR='nvim'
export VISUAL='nvim'

export PATH="/home/alex/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/alex/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

[ -f "/home/alex/.ghcup/env" ] && . "/home/alex/.ghcup/env" # ghcup-env
export CPLUS_INCLUDE_PATH="/opt/sfml2/include:$CPLUS_INCLUDE_PATH"
export LIBRARY_PATH="/opt/sfml2/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/opt/sfml2/lib:$LD_LIBRARY_PATH"
export PATH="$PATH:/home/alex/.local/bin"

function zle-keymap-select {
  echo -ne '\e[1 q'
}

zle-line-init() {
  echo -ne '\e[1 q'
}

zle -N zle-keymap-select
zle -N zle-line-init


# Added by Antigravity CLI installer
export PATH="/home/alex/.local/bin:$PATH"
