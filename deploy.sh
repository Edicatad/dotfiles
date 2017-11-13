#!/bin/bash
# Executes stow commands for git'd dotfiles

PROGRAMS=( "vim" "bash" )

for i in "${PROGRAMS[@]}"
do
    stow -t $HOME $1 $i
done
