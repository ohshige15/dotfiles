#!/bin/sh

echo 'start making symbolic links'

echo '.gitconfig'
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
echo '.gitignore'
ln -sf ~/dotfiles/.gitignore ~/.gitignore
echo '.zshrc'
ln -sf ~/dotfiles/.zshrc ~/.zshrc
echo '.zshrc.local'
ln -sf ~/dotfiles/.zshrc.local ~/.zshrc.local
echo '.vimrc'
ln -sf ~/dotfiles/.vimrc ~/.vimrc

echo 'end making'
