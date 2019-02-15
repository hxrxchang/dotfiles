echo 'hello Yuto!'
export PATH="$HOME/.ndenv/bin:$PATH"
eval "$(ndenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

ssh-add -K ~/.ssh/id_rsa

source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash

alias readbp='source ~/.bash_profile'
