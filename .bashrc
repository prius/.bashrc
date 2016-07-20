export PATH="${PATH}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Check if session is interactive and do nothing if it is
case "$-" in
*i*) true;;
*) return;;
esac

# setup SSH agent
if [ "x$SSH_AUTH_SOCK" = "x" ] ; then
    eval $(ssh-agent -s) >/dev/null
    ssh-add >/dev/null 2>&1
fi

# systemd variables
export SYSTEMD_PAGER=less

# Load local rc file for this machine
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# Load git-completion file
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

# Requires package bash-completion to be installed
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Create alias for sshrc
[ -f /usr/bin/sshrc ] && alias s='sshrc'

# Create systemd aliases
[ -f /usr/bin/systemctl ] && alias sctl='sudo systemctl'
[ -f /usr/bin/journalctl ] && alias jctl='sudo journalctl'

# Ignore duplicates in .bash_history
export HISTCONTROL=ignoredups
# The  maximum  number of lines contained in the history file.
export HISTFILESIZE=99999
# Controls output of `history` command end enables time logging in .bash_history
export HISTTIMEFORMAT="%a, %d %b %Y %T %z"

function hs {
    grep -a "$*" $HISTFILE
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Autocompletion options
set show-all-if-ambiguous on
set show-all-if-unmodified on
complete -cf sudo
complete -cf man

# SSHRC config

# Set vim to /usr/bin/vim, because on some systems /bin/vim is alias for /bin/vi
[ "x${SSHHOME}" != "x" ] && alias vim="/usr/bin/vim -u ${SSHHOME}/.sshrc.d/.vimrc"

case $(uname) in
    FreeBSD)
        MD5SUM='md5'
        STAT_TIME='stat -f%m'
        export LS_OPTIONS='-G'
        if command -v dircolors >/dev/null 2>&1
        then
            eval $(dircolors)
        fi
        ;;
    Linux)
        MD5SUM='md5sum'
        STAT_TIME='stat -c%Z'
        LS_OPTIONS='--color=auto'
        alias grep='grep --color=auto'    
        alias chown='chown --preserve-root'
        alias chmod='chmod --preserve-root'
        alias chgrp='chgrp --preserve-root'
        ;;
    *)
        MD5SUM='md5sum'
        STAT_TIME='stat -c%Z'
        ;;
esac

# Aliases
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias mkdir='mkdir -p -v'
alias ls='ls $LS_OPTIONS'
alias ll='ls -lA $LS_OPTIONS'
alias vi='vim'
alias debuild='debuild -i; debuild clean'
alias acp='apt-cache policy'
alias acs='apt-cache show'
alias agi='apt-get -V install'
alias less='less --line-numbers --ignore-case --underline-special -R'
alias sqlplus='rlwrap sqlplus'

# safety features
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# some functions
function mkdircd {
    mkdir $1
    cd $1
}

# add -i or -I (for newer coreutils versions) option to /bin/rm command
rmtemp=$(mktemp)
if rm -I $rmtemp &>/dev/null; then
    alias rm="rm -I"
else
    alias rm="rm -i"
    rm $rmtemp;
fi

EDITOR=vim
export EDITOR

# Reset
Color_Off='\[\e[0m\]'       # Text Reset

# Regular Colors
Black='\[\e[0;30m\]'        # Black
Red='\[\e[0;31m\]'          # Red
Green='\[\e[0;32m\]'        # Green
Yellow='\[\e[0;33m\]'       # Yellow
Blue='\[\e[0;34m\]'         # Blue
Purple='\[\e[0;35m\]'       # Purple
Cyan='\[\e[0;36m\]'         # Cyan
White='\[\e[0;37m\]'        # White

# Bold
BBlack='\[\e[1;30m\]'       # Black
BRed='\[\e[1;31m\]'         # Red
BGreen='\[\e[1;32m\]'       # Green
BYellow='\[\e[1;33m\]'      # Yellow
BBlue='\[\e[1;34m\]'        # Blue
BPurple='\[\e[1;35m\]'      # Purple
BCyan='\[\e[1;36m\]'        # Cyan
BWhite='\[\e[1;37m\]'       # White

# Underline
UBlack='\[\e[4;30m\]'       # Black
URed='\[\e[4;31m\]'         # Red
UGreen='\[\e[4;32m\]'       # Green
UYellow='\[\e[4;33m\]'      # Yellow
UBlue='\[\e[4;34m\]'        # Blue
UPurple='\[\e[4;35m\]'      # Purple
UCyan='\[\e[4;36m\]'        # Cyan
UWhite='\[\e[4;37m\]'       # White

# Background
On_Black='\[\e[40m\]'       # Black
On_Red='\[\e[41m\]'         # Red
On_Green='\[\e[42m\]'       # Green
On_Yellow='\[\e[43m\]'      # Yellow
On_Blue='\[\e[44m\]'        # Blue
On_Purple='\[\e[45m\]'      # Purple
On_Cyan='\[\e[46m\]'        # Cyan
On_White='\[\e[47m\]'       # White

# High Intensity
IBlack='\[\e[0;90m\]'       # Black
IRed='\[\e[0;91m\]'         # Red
IGreen='\[\e[0;92m\]'       # Green
IYellow='\[\e[0;93m\]'      # Yellow
IBlue='\[\e[0;94m\]'        # Blue
IPurple='\[\e[0;95m\]'      # Purple
ICyan='\[\e[0;96m\]'        # Cyan
IWhite='\[\e[0;97m\]'       # White

# Bold High Intensity
BIBlack='\[\e[1;90m\]'      # Black
BIRed='\[\e[1;91m\]'        # Red
BIGreen='\[\e[1;92m\]'      # Green
BIYellow='\[\e[1;93m\]'     # Yellow
BIBlue='\[\e[1;94m\]'       # Blue
BIPurple='\[\e[1;95m\]'     # Purple
BICyan='\[\e[1;96m\]'       # Cyan
BIWhite='\[\e[1;97m\]'      # White

# High Intensity backgrounds
On_IBlack='\[\e[0;100m\]'   # Black
On_IRed='\[\e[0;101m\]'     # Red
On_IGreen='\[\e[0;102m\]'   # Green
On_IYellow='\[\e[0;103m\]'  # Yellow
On_IBlue='\[\e[0;104m\]'    # Blue
On_IPurple='\[\e[10;95m\]'  # Purple
On_ICyan='\[\e[0;106m\]'    # Cyan
On_IWhite='\[\e[0;107m\]'   # White


if command -v fortune >/dev/null 2>&1
then
    if command -v fmt >/dev/null 2>&1
    then
        if command -v cowsay >/dev/null 2>&1
        then
            if command -v shuf >/dev/null 2>&1
            then
                FORTUNE=$(fortune -a | fmt -80 -s | cowsay -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n)
                echo -e "\e[1;36m$FORTUNE"
            fi
        fi
    fi
fi

# Print system info
echo -e "\e[1;36m     FQDN: "$(hostname -f)
echo -e "\e[1;36m       LA: "$(cat /proc/loadavg | cut -f 1-4 -d' ')

# Convert c1.h1.domain.com to c1.h1 except h1
SHORT_HOSTNAME=$(hostname -f | sed "s/\.[^\.]*\.[^\.]*$//g")

# Display nonzero exitcode (if we are allowed to modify PROMPT_COMMAND)
if unset $PROMPT_COMMAND 2>/dev/null;
then
    PROMPT_COMMAND='echo -ne "\033]0;$(whoami)@'${SHORT_HOSTNAME}' : $PWD\007";'
    PROMPT_COMMAND='RET=$?; if ! [[ $RET -eq 0 ]]; then echo -e "\033[0;31m$RET\033[0m ;("; fi; '$PROMPT_COMMAND
fi

if [[ $UID -ne 0 ]]
then
    PROMPT='$'
    export PS1="$BIGreen\u$BIRed@$BICyan${SHORT_HOSTNAME} $BIYellow\W $BICyan$PROMPT $Color_Off"
else
    PROMPT='#'
    export PS1="$BIRed\u$BIGreen@$BICyan${SHORT_HOSTNAME} $BIYellow\W $BICyan$PROMPT $Color_Off"
fi
