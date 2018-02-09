# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything.   
[ -z "$PS1" ] && return                                                                                                                                                           
# Colour settings {{{
# Colour settings for use in this bash file
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
WHITE='\033[0;37m'
YELLOW='\033[0;33m'
NOCOLOUR='\033[00m'
# }}}
# History settings {{{
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
PROMPTROOTCOLOUR="${RED}\]"
PROMPTUSERCOLOUR="${GREEN}\]"
PROMPTPATHCOLOUR="${YELLOW}\]"
PROMPTNOCOLOUR="${NOCOLOUR}\]"
# }}}
# Current prompt:
# [hist][user@host pwd]$ 
if [ $(id -u) -eq 0 ];
then # I am root
    PS1="${PROMPTROOTCOLOUR}[${PROMPTNOCOLOUR}\!${PROMPTROOTCOLOUR}][\[\u@\h ${PROMPTPATHCOLOUR}\w${PROMPTROOTCOLOUR}]\\$ ${PROMPTNOCOLOUR}"
else
    PS1="${PROMPTUSERCOLOUR}[${PROMPTNOCOLOUR}\!${PROMPTUSERCOLOUR}][\[\u@\h ${PROMPTPATHCOLOUR}\w${PROMPTUSERCOLOUR}]\\$ ${PROMPTNOCOLOUR}"
fi
# }}}
# Editor settings {{{
# setup vi as the default editor
set -o vi
export EDITOR=vim
# }}}
# {{{ Fzf & ripgrep
# Source fzf if it exists
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Make fzf use ripgrep for speed
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'
# }}}
# {{{ Path settings
# }}}
# Launch script {{{
# Tmux-specific commands
if [ -z $TMUX ] then
    export TERM=xterm-256color
    # Make fzf use a tmux pane for output
    export FZF_TMUX=1
    exec tmux
fi

# Fix urxvt colour rendering
xrdb ~/.Xresources

# Print a fancy tree in the terminal!
LEAFCOLOUR=$RED
BARKCOLOUR=$WHITE

echo
echo -e "               ${LEAFCOLOUR}&&&"
echo -e "             &&&&&&"
echo -e "          &&&&${BARKCOLOUR}\\/${LEAFCOLOUR}&&& &&&"
echo -e "         &&&${BARKCOLOUR}|,/   |/${LEAFCOLOUR}& &&&"
echo -e "          &&&${BARKCOLOUR}/   /   /_${LEAFCOLOUR}&&& &&&${BARKCOLOUR}"
echo -e "             \\  {  ,/_____/_${LEAFCOLOUR}&&  &&${BARKCOLOUR}"
echo -e "             {  / /           ${LEAFCOLOUR}&&${BARKCOLOUR},${LEAFCOLOUR}&&${BARKCOLOUR}"
echo -e "             \`, \\{==_     ,____/_${LEAFCOLOUR}&&&&${BARKCOLOUR}"
echo -e "               } }/ \`\\___{    ${LEAFCOLOUR}&${BARKCOLOUR}\`${LEAFCOLOUR}&&${BARKCOLOUR}"
echo -e "              }{{         \\____${LEAFCOLOUR}&&&&${BARKCOLOUR}"
echo -e "             {}{            \`${LEAFCOLOUR}&${BARKCOLOUR}\\\\${LEAFCOLOUR}&&&${BARKCOLOUR}"
echo -e "            }{{               ${LEAFCOLOUR}&&&${BARKCOLOUR}"
echo -e "      , -=-~{ .-^- _"
echo -e "            \`}"
echo -e "            {${NOCOLOUR}" # this removes the colouring from the rest of the output
date
# }}}

# vim:foldmethod=marker:foldlevel=0
