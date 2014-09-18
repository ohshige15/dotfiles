#!/bin/sh

echo 'start making symbolic links'

echo '.gitconfig'
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

echo 'end making'
