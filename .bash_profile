echo 'hello Yuto!'

# Set PATH, MANPATH, etc., for Homebrew.
if [[ $(uname -p) == 'arm' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

source ~/.bashrc
