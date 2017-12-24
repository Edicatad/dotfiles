#!/bin/bash
# Clones git repos or otherwise fetches vim plugins

REPOS=(
    "https://github.com/scrooloose/nerdtree" 
    "https://github.com/sickill/vim-monokai"
    )

echo "Cloning vim plugins from GitHub"
cd vim/.vim/bundle
for j in "${REPOS[@]}"
do
    REPONAME="${j##*/}"
    if [ -s "${REPONAME}" ]; then
        printf "  Pulling %-63s" "${REPONAME}"
        cd "${REPONAME}"
        OUTPUT="$(git pull 2>&1)"
        RC="$?"
        cd ..
    else
        printf "  Cloning %-63s" "$j"
        OUTPUT="$(git clone $j 2>&1)"
        RC="$?"
    fi
    if [ ${RC} -eq 0 ]; then
        printf  "\e[1;32m[OK]\e[0m\n"
    else
        printf  "\e[1;31m[Error]\e[0m\n"
        echo    "    exited with error code ${RC}"
        printf  "    %s\n" "$(echo "${OUTPUT}" | sed '2,$s/^/    /g')"
    fi
done
cd ../../..

# Executes stow commands for git'd dotfiles

PROGRAMS=(
    "vim"
    "bash" 
    "tmux"
    )

echo "Arguments supplied for GNU Stow: '-t ${HOME} ${1}'"
echo 'Deploying configuration files:'
for i in "${PROGRAMS[@]}"
do
    printf "  Deploying %-61s" "$i"
    OUTPUT="$(stow -t $HOME $1 $i 2>&1)"
    RC="$?"
    if [ ${RC} -eq 0 ]; then
        printf  "\e[1;32m[OK]\e[0m\n"
    else
        printf  "\e[1;31m[Error]\e[0m\n"
        echo    "    exited with error code ${RC}"
        printf  "    %s\n" "$(echo "${OUTPUT}" | sed '2,$s/^/    /g')"
    fi
done
