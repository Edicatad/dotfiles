# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything.   
[ -z "$PS1" ] && return                                                                                                                                                           
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
# Current prompt:
# [hist][user@host pwd]$ 
if [ $(id -u) -eq 0 ];
then # I am root
    PS1='\e[1;31m\][\e[m\]\!\e[1;31m\]][\[\u@\h \w]\#\[\e[m\] '
else
    PS1='\e[1;32m\][\e[m\]\!\e[1;32m\]][\[\u@\h \w]\$\[\e[m\] '
fi
# }}}
# Editor settings {{{
# setup vi as the default editor
set -o vi
export EDITOR=vim
# }}}
# Launch script {{{
# start in tmux if available
[ -z $TMUX ] && export TERM=xterm-256color && exec tmux

# Print a fancy tree in the terminal!
LEAFCOLOUR='\033[0;31m'
BARKCOLOUR='\033[0;37m'

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
echo -e "            {\033[0m" # this removes the colouring from the rest of the output
date
# }}}

# vim:foldmethod=marker:foldlevel=0
