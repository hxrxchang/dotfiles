echo 'hello Yuto!'

export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"
export PATH="$HOME/.yarn/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

ssh-add -K ~/.ssh/id_rsa

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

alias readbp='source ~/.bash_profile'
alias checkip='ifconfig | grep "inet " | grep -v 127.0.0.1'
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export DISABLE_SPRING=1
