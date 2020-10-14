alias rm="gomi"
alias sbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias ll='ls -alF -h'
alias chrome="open -a '/Applications/Google Chrome.app'"
alias slack="open -a '/Applications/Slack.app'"

## git
alias g='git'
alias commit-diff='git diff HEAD~..HEAD'
alias gsw='git branch | peco | xargs git switch'
alias cleanbranches='git branch | grep -v "master" | grep -v "*" | xargs git branch -D'
alias gsee='git-remote-opener'

alias his="peco_search_history"
alias app="peco_search_app"

alias save-vscode-extensions="code --list-extensions > ~/dotfiles/vscode/extensions.list"
alias install-vscode-extensions="cat ~/dotfiles/vscode/extensions.list | xargs -L 1 code --install-extension"

alias brew-dump="cd ~/dotfiles && rm Brewfile && brew bundle dump"
alias brew-bundle="cd ~/dotfiles && brew bundle"
