# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything.   
[ -z "$PS1" ] && return                                                                                                                                                           
# Colour settings {{{
# Colour settings for use in this bash file
colour_cyan='\033[0;36m'
colour_green='\033[0;32m'
colour_red='\033[0;31m'
colour_white='\033[0;37m'
colour_yellow='\033[0;33m'
no_colour='\033[00m'
# Base16 shell script
if [ -d $HOME/.dotfiles-tools/base16-shell ]; then
    BASE16_SHELL=$HOME/.dotfiles-tools/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi
# }}}
# History settings {{{
# Make sure all terminals save history
# Checks that PROMPT_COMMAND is not read-only
if unset PROMPT_COMMAND 2> /dev/null
then
    PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND-}"
fi

# don't put duplicate lines in the history or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace                                                                                              
# append to the history file, don't overwrite it    
shopt -s histappend                                                                                                                                                                                                        
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000                                       
HISTFILESIZE=200000                                                                                                              
# }}}
# Window settings {{{
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. 
shopt -s checkwinsize  
# }}}
# Prompt settings {{{
# Prompt colour settings {{{
prompt_path_colour="${colour_yellow}\]"
prompt_no_colour="${no_colour}\]"
if [ $(id -u) -eq 0 ];
then # I am root
    prompt_base_colour="${colour_red}\]"
else
    prompt_base_colour="${colour_green}\]"
fi
# }}}
# Current prompt:
# [hist][user@host pwd]$ 
prompt="${prompt_base_colour}["
prompt+="${prompt_no_colour}\!"
prompt+="${prompt_base_colour}][\[\u@\h "
prompt+="${prompt_path_colour}\w"
prompt+="${prompt_base_colour}]\\$ "
prompt+="${prompt_no_colour}"
PS1="${prompt}"

# TODO Separate out prompt into logical steps (check root, then check ssh, etc)
# TODO Figure out a way to make prompt not change title (\033 apparently changes title)
# }}}
# Editor settings {{{
# setup vim as the default editor
export EDITOR=vim
# don't die on <C-s>
stty -ixon
# }}}
# {{{ Fzf & ripgrep
# Source fzf if it exists
if [ -f ~/.fzf.bash ]; then  
    source ~/.fzf.bash
    # Make fzf use ripgrep for speed
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    bind -x '"\C-p": vim $(fzf);'
    # Source colour scheme if it exists
    if [ -d $HOME/.dotfiles-colours/base16-fzf ]; then
        source $HOME/.dotfiles-colours/base16-fzf/bash/base16-flat.config
    fi
fi
# }}}
# {{{ Path settings
# }}}
# Launch script {{{
# Tmux-specific commands
if [ -z $TMUX ]; then
    export TERM=xterm-256color
    # Make fzf use a tmux pane for output
    export FZF_TMUX=1
    # -2 forces tmux to assume 256 colours
    exec tmux -2
fi

# Fix urxvt colour rendering
xrdb -load ~/.Xresources

# Print a fancy tree in the terminal!
leaf_colour=$colour_red
bark_colour=$colour_white

echo
echo -e "               ${leaf_colour}&&&"
echo -e "             &&&&&&"
echo -e "          &&&&${bark_colour}\\/${leaf_colour}&&& &&&"
echo -e "         &&&${bark_colour}|,/   |/${leaf_colour}& &&&"
echo -e "          &&&${bark_colour}/   /   /_${leaf_colour}&&& &&&${bark_colour}"
echo -e "             \\  {  ,/_____/_${leaf_colour}&&  &&${bark_colour}"
echo -e "             {  / /           ${leaf_colour}&&${bark_colour},${leaf_colour}&&${bark_colour}"
echo -e "             \`, \\{==_     ,____/_${leaf_colour}&&&&${bark_colour}"
echo -e "               } }/ \`\\___{    ${leaf_colour}&${bark_colour}\`${leaf_colour}&&${bark_colour}"
echo -e "              }{{         \\____${leaf_colour}&&&&${bark_colour}"
echo -e "             {}{            \`${leaf_colour}&${bark_colour}\\\\${leaf_colour}&&&${bark_colour}"
echo -e "            }{{               ${leaf_colour}&&&${bark_colour}"
echo -e "      , -=-~{ .-^- _"
echo -e "            \`}"
echo -e "            {${no_colour}" # this removes the colouring from the rest of the output
date
# }}}

# vim:foldmethod=marker:foldlevel=0
