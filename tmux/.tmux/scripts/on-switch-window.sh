#!/bin/bash
ACTIVEWINDOW=`tmux list-windows | grep -i active | grep -i ssh`
if [ "$ACTIVEWINDOW" = "" ]
then
        # We're not in a ssh window, so apply default formatting
        tmux set -g status-bg green
else
        # We're in a ssh window!
        tmux set -g status-bg colour9
fi
