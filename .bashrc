export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

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

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

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

export PATH=/Users/yuto.hara/.nimble/bin:$PATH

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

peco_cd() {
  local sw="1"
  while [ "$sw" != "0" ]
   do
		if [ "$sw" = "1" ];then
			local list=$(echo -e "---$PWD\n../\n$( ls -F | grep / )\n---Show hidden directory\n---Show files, $(echo $(ls -F | grep -v / ))\n---HOME DIRECTORY")
		elif [ "$sw" = "2" ];then
			local list=$(echo -e "---$PWD\n$( ls -a -F | grep / | sed 1d )\n---Hide hidden directory\n---Show files, $(echo $(ls -F | grep -v / ))\n---HOME DIRECTORY")
		else
			local list=$(echo -e "---BACK\n$( ls -F | grep -v / )")
		fi

		local slct=$(echo -e "$list" | peco )

		if [ "$slct" = "---$PWD" ];then
			local sw="0"
		elif [ "$slct" = "---Hide hidden directory" ];then
			local sw="1"
		elif [ "$slct" = "---Show hidden directory" ];then
			local sw="2"
		elif [ "$slct" = "---Show files, $(echo $(ls -F | grep -v / ))" ];then
			local sw=$(($sw+2))
		elif [ "$slct" = "---HOME DIRECTORY" ];then
			cd "$HOME"
		elif [[ "$slct" =~ / ]];then
			cd "$slct"
		elif [ "$slct" = "" ];then
			:
		else
			local sw=$(($sw-2))
		fi
   done
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

memo() {
    touch ~/memo/$(date "+%Y%m%d%H%M%S").md
    code ~/memo/
}

actgen() {
    if [ -z $2 ] ; then
        OPTION=""
    else
        OPTION="--lang=$2 --template=~/dotfiles/atcoder/template.$2"
    fi
    atcoder-tools gen $1 --workspace=. $OPTION
}

acttest() {
    if [ -z $2 ] ; then
        cmd="python main.py"
    elif [ $2 = "go" ] ; then
        cmd="go run main.go"
    fi
    cat "in_$1.txt" | $cmd
}

actadd() {
    cp ~/dotfiles/atcoder/template.$1 ./main.$1
}

cargo_compete_new() {
    cargo compete new $1
    cargo member include $1
}

cargo_compete_test() {
    cargo compete test $1
}

cargo_compete_submit() {
    cargo compete submit $1
}

peco_search_repo () {
  local selected_dir=$(ghq list -p | peco --prompt="repositories >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    cd ${selected_dir}
  fi
}

source ~/dotfiles/alias.sh

. "$HOME/.cargo/env" # https://www.rust-lang.org/ja/tools/install
source "$HOME/.rye/env"

[ -f "/Users/haray/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
