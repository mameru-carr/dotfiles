# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########################
# Personal Alias'
########################
# Disk Usage
alias du='du -h --max-depth=1'
# Install lsd from "https://github.com/lsd-rs/lsd"
alias ls='lsd'

# Cool
alias please='sudo'

#########################
# Bash Prompt
#########################
#########################
# Original Author on Github: Caesar Kabalan
# Link: https://gist.github.com/ckabalan/2732cf6368a0adfbe55f03be33286ab1

if [ -f ~/.git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  source ~/.git-prompt.sh
fi

function set_bash_prompt () {

	# Color codes for easy prompt building
	COLOR_DIVIDER="\[\e[30;1m\]"
	COLOR_CMDCOUNT="\[\e[34;1m\]"
	COLOR_USERNAME="\[\e[34;1m\]"
	COLOR_USERHOSTAT="\[\e[34;1m\]"
	COLOR_HOSTNAME="\[\e[34;1m\]"
	COLOR_GITBRANCH="\[\e[33;1m\]"
	COLOR_VENV="\[\e[33;1m\]"
	COLOR_GREEN="\[\e[32;1m\]"
	COLOR_PATH_OK="\[\e[32;1m\]"
	COLOR_PATH_ERR="\[\e[31;1m\]"
	COLOR_NONE="\[\e[0m\]"

        # Unicode Characters
        ARROW_SHADED=$'\u27aa'
        ARROW_STROKED=$'\u2917'
        ARROW_OUTLINED=$'\u27be'
        ARROW_RIBBON=$'\u2bb1'
        ARROW_HOOK=$'\u21aa'

        SKELETON=$'\u2620'
        ANCHOR=$'\u2693'
        TIBETIAN_MARK=$'\u0f06'


        # source: https://digitalfortress.tech/tutorial/setting-up-git-prompt-step-by-step/
        # store colors
        MAGENTA="\[\033[0;35m\]"
        YELLOW="\[\033[01;33m\]"
        BLUE="\[\033[00;34m\]"
        LIGHT_GRAY="\[\033[0;37m\]"
        CYAN="\[\033[0;36m\]"
        GREEN="\[\033[00;32m\]"
        RED="\[\033[0;31m\]"
        VIOLET='\[\033[01;35m\]'

	USERNAME_COLOR=$GREEN
	MY_PATH_COLOR=$MAGENTA

        local __git_branch_color="$GREEN"
        local __git_branch=$(__git_ps1 "%s");

        # colour branch name depending on state
        if [[ "${__git_branch}" =~ "*" ]]; then     # if repository is dirty
          __git_branch_color="$RED"
        elif [[ "${__git_branch}" =~ "$" ]]; then   # if there is something stashed
          __git_branch_color="$YELLOW"
        elif [[ "${__git_branch}" =~ "%" ]]; then   # if there are only untracked files
          __git_branch_color="$LIGHT_GRAY"
        elif [[ "${__git_branch}" =~ "+" ]]; then   # if there are staged files
          __git_branch_color="$CYAN"
        fi

        # Build the PS1 (Prompt String)
        #GIT="${COLOR_DIVIDER}$__git_branch_color $__git_branch${COLOR_DIVIDER}"
        GIT=" (${COLOR_DIVIDER}${__git_branch_color}${__git_branch}${COLOR_DIVIDER})"

	# Change the path color based on return value.

	if test $? -eq 0 ; then
		PATH_COLOR=${COLOR_PATH_OK}
	else
		PATH_COLOR=${COLOR_PATH_ERR}
	fi
        # Set the PS1 to be "[username:workingdirectory] (__git_ps1)"
        PS1="${COLOR_DIVIDER} ${SKELETON} [${USERNAME_COLOR}\u${COLOR_DIVIDER} : ${COLOR_DIVIDER}${MY_PATH_COLOR}\w${COLOR_DIVIDER}]"

        PS1="${PS1} ${TIBETIAN_MARK} ${GIT}"


        # Add Python VirtualEnv portion of the prompt, this adds "(venvname)"
	if ! test -z "$VIRTUAL_ENV" ; then
		PS1="${PS1} (${COLOR_DIVIDER}${COLOR_VENV}`basename \"$VIRTUAL_ENV\"`${COLOR_DIVIDER})"
	fi
	# Close out the prompt, this adds "]\n[username@hostname] "
        PS1="${PS1}\n ${ANCHOR} "
}

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export PROMPT_COMMAND=set_bash_prompt

# Diff-So-Fancy - Fancy Git Diff Output
# https://github.com/so-fancy/diff-so-fancy?tab=readme-ov-file
DIFF_SO_FANCY=~/.bash/diff-so-fancy/diff-so-fancy
export PATH=$PATH:$DIFF_SO_FANCY


# fzf - Command Line Fuzzy Finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# dotnet
export PATH="~/.dotnet:$PATH"
# Add .NET Core SDK tools
export PATH="$PATH:/home/phoenix/.dotnet/tools"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
