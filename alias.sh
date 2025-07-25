alias gm="gomi"
alias sbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias ll='ls -alF -h'
alias chrome="open -a '/Applications/Google Chrome.app'"
alias to="touch"
alias v="vim"
alias rpy="rye run python"

## git
alias g='git'
alias commit-diff='git diff HEAD~..HEAD'
alias gsw='git branch | peco | xargs git switch'
alias cleanbranches='~/branch-cleaner/branch-cleaner.sh'
alias gsee='gh repo view --web'

alias his="peco_search_history"
alias app="peco_search_app"
alias sd="peco_cd"
alias sr="peco_search_repo"

alias save-vscode-extensions="code --list-extensions > ~/dotfiles/vscode/extensions.list"
alias install-vscode-extensions="cat ~/dotfiles/vscode/extensions.list | xargs -L 1 code --install-extension"

alias edit-aws="vim ~/.aws/credentials"

alias sysset="open 'x-apple.systempreferences:'"

# check https://formulae.brew.sh/ before install
alias brew-dump="brew_dump"
alias brew-bundle="brew_bundle"
alias brew-cleanup="brew_cleanup"

alias cc="cargo compete"
alias ccn="cargo_compete_new"
alias cct="cargo_compete_test"
alias ccs="cargo_compete_submit"
alias ccu="cargo_compete_update"
alias rr="evcxr"

alias kc="kubectl"
