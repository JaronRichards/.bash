# ~/.bashrc: Executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Add alias definitions if they exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Append to the history file, don't overwrite it
export HISTTIMEFORMAT="%y-%m-%d %T "
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Setting history length
HISTSIZE=100000
HISTFILESIZE=20000000

# Check the window size after each command
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Custom color theme
COLOR_RED="\033[01;31m"
COLOR_YELLOW="\033[01;33m"
COLOR_GREEN="\033[01;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[01;34m"
COLOR_WHITE="\033[01;37m"
COLOR_RESET="\033[0m"

# Parse git status and display color based on it
parse_git_branch() {
    git branch 2> /dev/null |sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_color() {
    local git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working directory clean" ]]; then
      echo -e $COLOR_RED
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
      echo -e $COLOR_YELLOW
    elif [[ $git_status =~ "nothing to commit" ]]; then
      echo -e $COLOR_GREEN
    else
      echo -e $COLOR_OCHRE
    fi
}

# Set the PS1
PS1='\[\033[01;32m\]\u\[$(git_color)\]$(parse_git_branch)\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

