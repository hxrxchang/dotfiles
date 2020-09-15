alias rm="gomi"
alias sbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias ll='ls -alF'
alias chrome="open -a '/Applications/Google Chrome.app'"
alias slack="open -a '/Applications/Slack.app'"

## git
alias g='git'
alias commit-diff='git diff HEAD~..HEAD'
alias gsw='git branch | peco | xargs git switch'
alias cleanbranches='git branch | grep -v "master" | grep -v "*" | xargs git branch -D'
alias gsee='hubrowse'

alias his="peco_search_history"
alias app="peco_search_app"
