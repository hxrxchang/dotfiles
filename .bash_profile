echo 'hello Yuto!'

# for git
export PATH="/usr/local/bin:$PATH"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
export PATH="$HOME/.yarn/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

export DISABLE_SPRING=1

ssh-add -K ~/.ssh/id_rsa

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

alias readbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias ll='ls -alF'

# git
alias g='git'
alias commit-diff='git diff HEAD~..HEAD'
alias gsw='git branch | peco | xargs git switch'
alias cleanbranches='git branch | grep -v "master" | grep -v "*" | xargs git branch -D'
alias gsee='hub browse'

export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
source ~/.git-prompt.sh

eval "$(direnv hook bash)"

# catalinaでbash使っても警告させない
export BASH_SILENCE_DEPRECATION_WARNING=1

