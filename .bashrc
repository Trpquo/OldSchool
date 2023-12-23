#!/bin/bash
export TZ="/usr/share/zoneinfo/Europe/Zagreb"
export VIMINIT="source $VIMRC"
export VIMRC="$HOME/.config/vim/.vimrc"

alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ll="ls -lah"
alias lt="ls --tree 2 -ah"
alias cls=clear
alias cp ="cp -vi" # kopiraj interaktivno (da ne gazi automatski postojeće datoteke)
alias mv="mv -vi" # premještaj  interaktivno (da ne gazi automatski postojeće datoteke)
alias cpv="cp rsync -avh --info=progress2" # kopira uz progress-bar

grepin() {
  grep -Rnw "." -e "$1"
} # traži određenu riječ (string) u svim datotekama unutar određenog direktorija
alias vi=vim

alias bashrc="vim ~/.bashrc && sbrc"
alias sbrc="source ~/.bashrc"
alias vimrc="vim ~/.config/vim/.vimrc"
alias tmuxrc="vim ~/.config/tmux/tmux.conf"

PATH="~/.local/bin${PATH:+:${PATH}}"

tmux new
