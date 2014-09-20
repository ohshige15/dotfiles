#!/bin/sh

echo 'start making symbolic links'

echo '.gitconfig'
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
echo '.zshrc'
ln -sf ~/dotfiles/.zshrc ~/.zshrc

echo 'end making'
