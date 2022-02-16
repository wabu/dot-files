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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|screen) color_prompt=yes;;
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

[ -f /usr/share/git/git-prompt.sh ] && source /usr/share/git/git-prompt.sh
[ -f /usr/local/etc/bash_completion.d/git-completion.bash ] && source /usr/local/etc/bash_completion.d/git-completion.bash
[ -f /usr/local/etc/bash_completion.d/git-prompt.sh ] && source /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true

if [ "$color_prompt" = yes ]; then
  PROMPT_COMMAND='STATUS=$?; RELATIVE=${PWD/${ROOT_PWD}/.}; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/${HOME}/~}/\007"'
  case `hostname` in
      deukalion) col=36;;
      kottos) col=34;;
      gyges) col=30;;
      themis) col=35;;
      tethys) col=32;;
      *) col=33;;
  esac

  PS1='\[\033[00;04m\]${USER/danieldavis/dd}\[\033[30m\]@\[\033['$col'm\]${HOSTNAME/Daniels-MacBook-Pro.local/macbook}\[\033[00;04;34m\] \w\[\033[00;34m\]/$(__git_ps1 " [%s]") \[\033[00;04;31m\]${STATUS/0/}\[\033[00m\]\$ \[\033[00m\]'
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# some customizations
export EDITOR=nvim

#command -v thefuck >/dev/null && eval "$(thefuck --alias)"
#eval "$(thefuck --alias --enable-experimental-instant-mode)"

#for some nvim stuff?
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# auto conda-env
chdir() {
    previous="$(realpath .)"
    builtin "$@"
    current="$(realpath .)"
    
    name="$(   ([ -f environment.yml ] \
                && grep name environment.yml) \
            || ([ -f ../environment.yml ] \
                && grep name ../environment.yml)  \
            | sed 's/name: \(\w*\)/\1/;s/#.*$//')"
    if [[ "$name" != "$CONDA_DEFAULT_ENV" ]]; then
        if [[ -z "$CONDA_AUTOENV" ]] && 
           ! [[ $current/ == "$CONDA_AUTOENV"/* ]]; then
            echo ">> autoenv: leaving $CONDA_DEFAULT_ENV ($CONDA_AUTOENV)"
            conda deactivate
            unset CONDA_AUTOENV
        fi
	if [[ -n "$name" ]]; then
    	    export CONDA_AUTOENV="$current"
	    echo ">> autoenv: activating $name (environment.yml)"
            conda activate "$name"
	fi
    fi


    if [ -d .git ]; then
        git status --short --branch
    fi
}
alias cd='chdir cd'
alias pushd='chdir pushd'
alias popd='chdir popd'
alias 3ls='aws s3 ls'
alias 3ll='aws s3 ls --human-readable --summarize'
alias 3cp='aws s3 cp'
alias 3mv='aws s3 mv'
alias 3sync='aws s3 sync'
alias 3mb='aws s3 mb'
alias 3rb='aws s3 rb'

alias ls='ls -G'
alias ll='ls -laG'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

fortune | cowsay | lolcat
chdir
export WKNG_ENV=local
export LAB_APP=Chromium

alias onelogin="osascript -e 'tell application \"iTerm\" to display dialog \"Password:\" with title \"Onelogin\" with hidden answer default answer \"\" with icon note' -e 'text returned of result' | (cd ~/.onelogin && xargs onelogin-aws-assume-role --onelogin-password)"

mkcd () {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

