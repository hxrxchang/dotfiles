echo 'hello Yuto!'

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

export GOROOT=/usr/local/go

export DISABLE_SPRING=1

ssh-add -K ~/.ssh/id_rsa

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

alias readbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
alias cleanbranches='git branch | grep -v "master" | grep -v "*" | xargs git branch -D'
alias commit-diff='git diff HEAD~..HEAD'

export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
source ~/.git-prompt.sh

eval "$(direnv hook bash)"
export PATH="/usr/local/bin:$PATH"
