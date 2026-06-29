#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias emacs='emacs -nw'
alias pdf="sioyek"
alias epitechstyle="~/my_scripts/coding-style.sh"
alias cheatsheet="bat ~/brain/_system/_cheatsheet.md"
alias gotour="~/go/bin/tour"
alias glow="glow -l -w 80 -s ~/.config/glow/noclownfiesta.json"
export EDITOR='nvim'
export VISUAL='nvim'
export TERM=xterm-256color
export PATH="/home/alex/.config/herd-lite/bin:$PATH"
export PATH="$PATH:/home/alex/.local/bin"
export PHP_INI_SCAN_DIR="/home/alex/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

. "$HOME/.cargo/env"

[ -f "/home/alex/.ghcup/env" ] && . "/home/alex/.ghcup/env"

export CPLUS_INCLUDE_PATH="/opt/sfml2/include:$CPLUS_INCLUDE_PATH"
export LIBRARY_PATH="/opt/sfml2/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/opt/sfml2/lib:$LD_LIBRARY_PATH"
export DXVK_LOG_LEVEL=none

LAST_EXIT_CODE=0

get_git_branch() {
    git branch --show-current 2>/dev/null
}

set_prompt() {
    local exit_code=$?

    local git_branch
    git_branch=$(git branch --show-current 2>/dev/null)

    local git_part=""
    if [ -n "$git_branch" ]; then
        git_part=" \[\e[35m\]git:(\[\e[33m\]${git_branch}\[\e[35m\])"
    fi

    PS1="${exit_code} \[\e[36m\]\W\[\e[0m\]${git_part} \[\e[35m\]%\[\e[0m\] "
}

PROMPT_COMMAND=set_prompt

alias mountusb='sudo mkdir -p /run/media/alex/M-O && sudo mount /dev/sda1 /run/media/alex/M-O && cd /run/media/alex/M-O'
alias yta='yt-dlp -x --audio-format mp3'
export PATH="/home/alex/.local/bin:$PATH"
