#!/bin/bash
export TZ="/usr/share/zoneinfo/Europe/Zagreb"
export VIMINIT="source $VIMRC"
export VIMRC="$HOME/.config/vim/.vimrc"

alias ll="ls -lah"
alias lt="ls --tree 2 -ah"
alias cls=clear
alias vi=vim

alias bashrc="vim ~/.bashrc && sbrc"
alias sbrc="source ~/.bashrc"
alias vimrc="vim ~/.config/vim/.vimrc"
alias tmuxrc="vim ~/.config/tmux/tmux.conf"

PATH="~/.local/bin${PATH:+:${PATH}}"

tmux new
