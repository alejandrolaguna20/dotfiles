export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

setopt PROMPT_SUBST

precmd() {
  LAST_EXIT_CODE=$?
}

git_branch() {
  local branch
  branch=$(git branch --show-current 2>/dev/null)
  [[ -n $branch ]] && echo " %F{#62A0EA}${branch}%f"
}

exit_status() {
  echo "%F{#A0A0A0}${LAST_EXIT_CODE}%f "
}

PROMPT='$(exit_status)%F{#33B2A4}%1~%f$(git_branch) %F{#5E5E5E}%%%f '

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
