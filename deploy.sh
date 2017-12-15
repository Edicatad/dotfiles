#!/bin/bash
# Clones git repos or otherwise fetches vim plugins

REPOS=(
    "https://github.com/scrooloose/nerdtree.git" 
    "https://github.com/sickill/vim-monokai"
    )

cd vim/.vim/bundle
for j in "${REPOS[@]}"
do
    git clone $j
done
cd ../../..

# Executes stow commands for git'd dotfiles

PROGRAMS=(
    "vim"
    "bash" 
    "tmux"
    )

for i in "${PROGRAMS[@]}"
do
    stow -t $HOME $1 $i
done
