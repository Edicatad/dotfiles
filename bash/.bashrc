# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything.   
[ -z "$PS1" ] && return                                                                                                                                                           
# don't put duplicate lines in the history or force ignoredups and ignorespace                                                                                                                                 
HISTCONTROL=ignoredups:ignorespace                                                                                              
# append to the history file, don't overwrite it    
shopt -s histappend                                                                                                                                                                                                        
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000                                       
HISTFILESIZE=200000                                                                                                              
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS. 
shopt -s checkwinsize  
# prompt setup
if [ $(id -u) -eq 0 ];
then # I am root
    PS1='\[\e[1;31m\][\u@\h \w]\#\[\e[m\] '
else
    PS1='\[\e[1;32m\][\u@\h \w]\$\[\e[m\] '
fi
# setup vi as the default editor
set -o vi
export EDITOR=vim
# start in tmux if available
[ -z $TMUX ] && export TERM=xterm-256color && exec tmux

uname -n | figlet
date
