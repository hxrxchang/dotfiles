#!/bin/bash

ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
if [ "$CODESPACES" = "true" ];then
    ln -sf ~/dotfiles/git/.gitconfig_codespaces ~/.gitconfig
else
    ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
fi
ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/git/.git-templates ~/.git-templates
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
ln -sf ~/dotfiles/atcoder/.atcodertools.toml ~/.atcodertools.toml
ln -sf ~/dotfiles/.cargo/config ~/.cargo/config
