#!/bin/sh

echo 'start making symbolic links'

echo '.gitconfig'
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
echo '.gitignore'
ln -sf ~/dotfiles/.gitignore ~/.gitignore
echo '.zshrc'
ln -sf ~/dotfiles/.zshrc ~/.zshrc
echo '.zshrc.alias'
ln -sf ~/dotfiles/.zshrc.alias ~/.zshrc.alias
echo '.vimrc'
ln -sf ~/dotfiles/.vimrc ~/.vimrc

echo 'end making'
