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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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
[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] && source /usr/share/git-core/contrib/completion/git-prompt.sh

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

  PS1='\[\033[00;04m\]\u\[\033[37m\]@\[\033['$col'm\]\h\[\033[00;04;34m\] \w\[\033[00;34m\]/$(__git_ps1 " [%s]") \[\033[00;04;31m\]${STATUS/0/}\[\033[00m\]\$ \[\033[00m\]'
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
export EDITOR=vim

if [ -x /opt/anaconda/bin/conda ]; then
  export PATH=/opt/anaconda/bin:$PATH
elif [ -x ~/install/conda/bin/conda ]; then
  export PATH=~/install/conda/bin:$PATH
fi

# enable good old eiabox
[ -d /usr/java/default ] && export JAVA_HOME=/usr/java/default/
[ -d /opt/eiabox ] && { pushd /opt/eiabox; source sourceit.env; popd; } > /dev/null

command -v thefuck >/dev/null && eval "$(thefuck --alias)"
#eval "$(thefuck --alias --enable-experimental-instant-mode)"

#for some nvim stuff?
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/wabu/install/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/wabu/install/conda/etc/profile.d/conda.sh" ]; then
        . "/home/wabu/install/conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/wabu/install/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# auto conda-env
chdir() {
    previous="$(realpath .)"
    builtin "$@"
    current="$(realpath .)"
    
    name="$([ -f environment.yml ] \
            && grep name environment.yml \
	    | sed 's/name\s*:\s*//;s/#.*$//')"
    if [[ "$name" != "$CONDA_DEFAULT_ENV" ]]; then
        if [[ -v CONDA_AUTOENV ]] && 
           ! [[ $current/ == "$CONDA_AUTOENV"/* ]]; then
            echo ">> autoenv: leaving $CONDA_DEFAULT_ENV ($CONDA_AUTOENV)"
            conda deactivate
            unset CONDA_AUTOENV
        fi
	if [[ -n "$name" ]]; then
    	    export CONDA_AUTOENV="$current"
	    echo ">> autoenv: activating $name (environment.yaml)"
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
