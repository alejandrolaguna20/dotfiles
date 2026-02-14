export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME=""


setopt PROMPT_SUBST

# Save last exit code BEFORE running anything else
precmd() {
  LAST_EXIT_CODE=$?
}

git_branch() {
  local branch
  branch=$(git branch --show-current 2>/dev/null)
  [[ -n $branch ]] && echo " %F{magenta}git:(%F{cyan}${branch}%F{magenta})%f"
}

PROMPT='${LAST_EXIT_CODE} %F{blue}%1~%f$(git_branch) %% '


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

export PATH="$PATH:/home/alex/.local/bin"
