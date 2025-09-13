export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

# 履歴設定
export HISTFILE=~/.bash_history
export HISTSIZE=2000
export HISTFILESIZE=2000
shopt -s histappend

# 履歴共有と保存を両立
PROMPT_COMMAND='history -a; history -c; history -r; starship_precmd'

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
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export PATH="~/.nimble/bin:$PATH"
export PATH="$PATH:~/Library/Application Support/Coursier/bin"

# for direnv
export EDITOR=vim
eval "$(direnv hook bash)"

# 環境変数読み込み
if [ -f ~/dotfiles/.env.private.sh ]; then
    source ~/dotfiles/.env.private.sh
fi

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
    cm
    code ~/memo/
}

acgen() {
    if [ -z $1 ]; then
        echo "Please specify the contest and language"
        return
    fi
    if [ -z $2 ]; then
        echo "Please specify the language"
        return
    fi
    acc new $1
    directories=$(find $1 -maxdepth 1 -type d ! -name $1)
    if [ "$CODESPACES" = "true" ]; then
        for dir in $directories; do
            cp  /workspaces/atcoder/template/main.$2 $dir/main.$2
        done
    else
        for dir in $directories; do
            cp  ~/ghq/github.com/hxrxchang/atcoder/template/main.$2 $dir/main.$2
        done
    fi
}

act() {
    if [ -z $1 ]; then
        echo "Please specify the language and sample"
        return
    fi
    if [ -z $2 ]; then
        echo "Please specify the sample"
        return
    fi
    if [ $1 = "go" ] ; then
        cmd="go run main.go"
    elif [ $1 = "py" ] ; then
        cmd="python main.py"
    fi
    cat "tests/sample-$2.in" | $cmd
}

actest() {
    if [ -z $1 ]; then
        echo "Please specify the language"
        return
    fi
    if [ $1 = "go" ]; then
        cmd="go run main.go"
    elif [ $1 = "py" ]; then
        cmd="python main.py"
    fi
    echo $cmd
    oj t -c "$cmd" -d ./tests/
}

acs() {
    if [ -z $1 ]; then
        echo "Please specify the language"
        return
    fi
    if [ $1 = "go" ]; then
        lang_id=5002
    elif [ $1 = "py" ]; then
        lang_id=5078
    fi
    acc submit main.$1 -- -l $lang_id
}

acadd() {
    acc add
}

acaddl() {
    if [ -z $1 ]; then
        echo "Please specify the language"
        return
    fi
    if [ "$CODESPACES" = "true" ]; then
        cp /workspaces/atcoder/template/main.$1 ./main.$1
    else
        cp ~/ghq/github.com/hxrxchang/atcoder/template/main.$1 ./main.$1
    fi

}

cc_new() {
    cargo compete new $1
    cargo member include $1
}

cc_test() {
    cargo compete test $1
}

cc_submit() {
    cargo compete submit $1
}

cc_update() {
  if [ $# -ne 1 ]; then
    echo "Usage: cargo_compete_update <problem>" >&2
    return 1
  fi

  problem="$1"
  src_path="./src/bin/${problem}.rs"
  main_path="../src/main.rs"

  # カレントディレクトリが cargo-compete で生成された問題ディレクトリかどうかを判定
  if [ ! -d "./src/bin" ]; then
    echo "Error: カレントディレクトリが cargo-compete により生成されたディレクトリではないようです（./src/bin が存在しません）" >&2
    return 1
  fi

  if [ ! -f "$src_path" ]; then
    echo "Error: 問題ファイル '${src_path}' が存在しません" >&2
    return 1
  fi

  if [ ! -f "$main_path" ]; then
    echo "Error: main.rs の出力先 '${main_path}' が存在しません" >&2
    return 1
  fi

  cp "$src_path" "$main_path"
  echo "✅ ${src_path} を ${main_path} にコピーしました。"
}

cc_run() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <a|b|c|...>"
        exit 1
    fi

    # カレントディレクトリ名
    DIR_NAME=$(basename "$PWD")

    # cargo run 実行
    cargo run --bin "${DIR_NAME}-$1"
}

cc_create_test_dir() {
    for file in testcases/*.yml; do
        # ファイル名だけ取り出す（拡張子除く）
        name=$(basename "$file" .yml)
        # ディレクトリ作成
        mkdir -p "testcases/$name/in"
        mkdir -p "testcases/$name/out"
        echo "Created directories for problem: $name"
    done
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

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# pnpm
export PNPM_HOME="/Users/haray/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(~/.local/bin/mise activate bash)"
