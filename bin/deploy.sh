#!/bin/bash
# Clones git repos or otherwise fetches vim plugins

VIMPLUGINS=(
"https://github.com/scrooloose/nerdtree" 
"https://github.com/chriskempson/base16-vim"
)

STOWPROGRAMS=(
"vim"
"bash" 
"tmux"
"mutt"
"xresources"
)

CLITOOLS=(
"https://github.com/chriskempson/base16-shell"
)

COLOURSCHEME=(
"https://github.com/nicodebo/base16-fzf"
)

#=====
#  Function
#
#  Loops through an array of git repositories looking for a folder
#  of the same name.  If it finds one, it pulls that repository, 
#  and if not it clones it.
#
#  Params
#  $1: Name of an array containing git repository urls
#==
function _clone_or_pull_repos {
    arrayname=$1[@]
    array=("${!arrayname}")
    for j in "${array[@]}"
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
            OUTPUT="$(git clone --depth 1 $j 2>&1)"
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
}

echo "Cloning vim plugins using git"
cd vim/.vim/bundle
_clone_or_pull_repos VIMPLUGINS
cd ../../..

# Executes stow commands for git'd dotfiles

echo "Arguments supplied for GNU Stow: '-t ${HOME} ${1}'"
echo 'Deploying configuration files:'
for i in "${STOWPROGRAMS[@]}"
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

# Symlink userdata
if [ -d ~/.dotfiles-userdata ]; then
    read -t 3 -p "Do you want to overwrite userdata? [yN]" answer
    case ${answer:0:1} in
        y|Y )
            echo "Overwriting userdata"
            ln -sfh "$(pwd)/userdata" ~/.dotfiles-userdata
            ;;
        * ) echo ;;
    esac
else
    echo "Creating userdata stubs in ~/.dotfiles-userdata"
    ln -s "$(pwd)/userdata" ~/.dotfiles-userdata
fi

# Symlink tools
read -t 3 -p "Do you want to install the basic tools? [Yn]" answer
case ${answer:0:1} in
    n|N ) echo ;;
    * ) 
        echo
        echo "Cloning tools using git"
        cd tools
        _clone_or_pull_repos CLITOOLS
        cd ..
        ln -sfh "$(pwd)/tools" ~/.dotfiles-tools
        ;;
esac

# Fetch colour scheme
read -t 3 -p "Do you want to install the current colour scheme? [Yn]" answer
case ${answer:0:1} in
    n|N) echo ;;
    *)
        echo
        echo "Cloning colourscheme using git"
        cd colour
        _clone_or_pull_repos COLOURSCHEME
        cd ..
        ln -sfh "$(pwd)/colour" ~/.dotfiles-colours
        ;;
esac
