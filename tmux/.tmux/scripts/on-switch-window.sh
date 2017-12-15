#!/bin/bash
WINDOWNAME=`tmux display-message -p '#W'`
if [ "$WINDOWNAME" = "ssh" ]
then
        # We're in a ssh window!
        tmux set -g status-bg colour9
else
        # We're not in a ssh window, so apply default formatting
        tmux set -g status-bg green
fi
