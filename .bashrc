# terminal間で履歴共有
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=2000

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
export PATH="$HOME/.yarn/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="/usr/local/opt/libiconv/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# for direnv
export EDITOR=vim
eval "$(direnv hook bash)"

export DISABLE_SPRING=1

export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
source ~/dotfiles/git/.git-prompt.sh
source ~/dotfiles/git/.git-completion.bash

# catalinaでbash使っても警告させない
export BASH_SILENCE_DEPRECATION_WARNING=1

eval "$(starship init bash)"
export STARSHIP_CONFIG=~/dotfiles/starship/starship.toml

PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"

# pecoでhistory検索して実行できる関数
peco_search_history() {
    SELECTED_COMMAND=$(tail -r ~/.bash_history | peco)
    if [ "$SELECTED_COMMAND" != "" ]; then
        exec_and_add_history "$SELECTED_COMMAND"
    fi
}

peco_search_app() {
    SELECTED_APP=$(ls /Applications | peco)
    if [ "$SELECTED_APP" != "" ]; then
        OPEN_APP_COMMAND="open -a '/Applications/${SELECTED_APP}'"
        exec_and_add_history "$OPEN_APP_COMMAND"
    fi
}

exec_and_add_history() {
    echo "exec: ${1}"
    history -s $1
    eval $1
}

brew_dump() {
    current_dir=$(pwd)
    cd ~/dotfiles && rm Brewfile && brew bundle dump && cd $current_dir
}

brew_bundle() {
    current_dir=$(pwd)
    cd ~/dotfiles && brew bundle && cd $current_dir
}

brew_cleanup() {
    current_dir=$(pwd)
    cd ~/dotfiles && brew bundle cleanup && cd $current_dir
}

act_gen() {
    atcoder-tools gen $1 --without-login --workspace=.
}

source ~/dotfiles/alias.sh
# . "$HOME/.cargo/env"
