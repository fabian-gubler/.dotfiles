#!/bin/sh

export GPG_TTY=$(tty)
export PINENTRY_USER_DATA="USE_CURSES=0"
rbw "$@"
