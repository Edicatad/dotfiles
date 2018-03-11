#!/bin/bash
# Clones git repos or otherwise fetches vim plugins

VIM_PLUGINS=(
"https://github.com/scrooloose/nerdtree" 
"https://github.com/junegunn/fzf.vim"
"https://github.com/chriskempson/base16-vim"
"https://github.com/tpope/vim-surround"
"https://github.com/tpope/vim-fugitive"
)

STOW_PROGRAMS=(
"vim"
"bash" 
"tmux"
"mutt"
"xresources"
"newsbeuter"
)

CLI_TOOLS=(
"https://github.com/chriskempson/base16-shell"
)

COLOUR_SCHEME=(
"https://github.com/nicodebo/base16-fzf"
)

#=====
#  Script variables
#==
preset_answer=''
stow_args=''

#=====
#  Functions
#==

#=====
#  Reads user input.  This ensures we're using the same parameters
#  for every input query, and it makes the -yn flags possible.
#  
#  Params
#  $1: Query text
#==
function _read {
    if [ -z "${preset_answer}" ]; then
        read -t 3 -p "$1" answer
    else
        answer="${preset_answer}"
    fi
}

#=====
#  Loops through an array of git repositories looking for a folder
#  of the same name.  If it finds one, it pulls that repository, 
#  and if not it clones it.
#
#  Params
#  $1: Name of an array containing git repository urls
#==
function _clone_or_pull_repos {
    array_name=$1[@]
    array=("${!array_name}")
    for j in "${array[@]}"
    do
        repo_name="${j##*/}"
        if [ -s "${repo_name}" ]; then
            printf "  Pulling %-63s" "${repo_name}"
            cd "${repo_name}"
            output="$(git pull 2>&1)"
            exit_status="$?"
            cd ..
        else
            echo "New source found in $1: ${repo_name}"
            _read "Do you want to clone the repository [yN]"
            case ${answer:0:1} in
                y|Y )
                    printf "  Cloning %-63s" "$j"
                    output="$(git clone --depth 1 $j 2>&1)"
                    ;;
                * ) echo ;;
            esac
            exit_status="$?"
        fi
        if [ ${exit_status} -eq 0 ]; then
            printf  "\e[1;32m[OK]\e[0m\n"
        else
            printf  "\e[1;31m[Error]\e[0m\n"
            echo    "    exited with error code ${exit_status}"
            printf  "    %s\n" "$(echo "${output}" | sed '2,$s/^/    /g')"
        fi
    done
}

#=====
#  Safely symlinks regardless of *nix version
#
#  Params
#  $1: Link origin
#  $2: Link target
#==
function _link {
    uname_str="$(uname -s)"
    case "${uname_str}" in
        Linux*)
            ln -sfn $1 $2
            ;;
        Darwin*)
            ln -sfh $1 $2
            ;;
    esac
}

#=====
#  Script
#==

#=====
#  Parse command line flags
#==
while getopts ":ynr" option; do
    case "${option}" in
        y) preset_answer='y' ;;
        n) preset_answer='n' ;;
        r) stow_args="${stow_args} -R" ;;
        \?) echo "Unknown flag '${OPTARG}'" ;;
    esac
done

echo "Cloning vim plugins using git"
cd vim/.vim/bundle
_clone_or_pull_repos VIM_PLUGINS
cd ../../..

# Executes stow commands for git'd dotfiles

echo "Arguments supplied for GNU Stow: '-t ${HOME}${stow_args}'"
echo 'Deploying configuration files:'
for i in "${STOW_PROGRAMS[@]}"
do
    printf "  Deploying %-61s" "$i"
    output="$(stow -t $HOME $1 $i 2>&1)"
    exit_status="$?"
    if [ ${exit_status} -eq 0 ]; then
        printf  "\e[1;32m[OK]\e[0m\n"
    else
        printf  "\e[1;31m[Error]\e[0m\n"
        echo    "    exited with error code ${exit_status}"
        printf  "    %s\n" "$(echo "${output}" | sed '2,$s/^/    /g')"
    fi
done

# Symlink tools
echo "Cloning tools using git"
cd tools
_clone_or_pull_repos CLI_TOOLS
cd ..
_link "$(pwd)/tools" ~/.dotfiles-tools

# Fetch colour scheme
echo "Cloning colourscheme using git"
cd colour
_clone_or_pull_repos COLOUR_SCHEME
cd ..
_link "$(pwd)/colour" ~/.dotfiles-colours

# Symlink userdata
if [ -d ~/.dotfiles-userdata ]; then
    _read "Do you want to overwrite userdata? [yN]"
    case ${answer:0:1} in
        y|Y )
            echo "Overwriting userdata"
            _link "$(pwd)/userdata" ~/.dotfiles-userdata
            ;;
        * ) echo ;;
    esac
else
    echo "Creating userdata stubs in ~/.dotfiles-userdata"
    # ln -s is unambiguous so doesn't need a wrapper function
    ln -s "$(pwd)/userdata" ~/.dotfiles-userdata
fi

