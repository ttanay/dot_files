# --- ps1 ---
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[35m\][\u@\h] \[\033[36m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Infinite history: https://stackoverflow.com/questions/9457233/unlimited-bash-history
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Git Aliases
alias gst='git status'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gpo='git pull origin'

# k8s aliases
alias kp='kubectl get pods'
alias kctl='kubectl'
alias kl='kubectl logs'
alias kall='kubectl get all'

# Clang aliases
alias clang-format="clang-format-18"

# Python
alias python=python3

# UTF-8 locale
LANG="en_IN.utf8"
export LANG
