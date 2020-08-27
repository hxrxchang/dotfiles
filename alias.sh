alias readbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias ll='ls -alF'

## git
alias g='git'
alias commit-diff='git diff HEAD~..HEAD'
alias gsw='git branch | peco | xargs git switch'
alias cleanbranches='git branch | grep -v "master" | grep -v "*" | xargs git branch -D'
alias gsee='hub browse'

alias his="peco_search_history"
