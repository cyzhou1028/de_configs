# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/cyz/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline"

OMB_USE_SUDO=true

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# User defined functions

function imp() {

    if [ $# != 1 ]; then
        echo $# "arguments received; expected 1"
    elif [ $1 == "on" ]; then
        conda activate improv
        cd $HOME/Documents/research/improv
    elif [ $1 == "off" ]; then
        conda deactivate
        cd $HOME
    else
        echo "invalid arg:" $1
        echo "argument must be \"on\" or \"off\""
    fi
}

function access() {
    if [ $# != 1 ]; then
        echo $# "arguments received; expected 1"
    elif [ $1 == "on" ]; then
        ecryptfs-mount-private
    elif [ $1 == "off" ]; then
        ecryptfs-umount-private
    else
        echo "invalid arg:" $1
        echo "argument must be \"on\" or \"off\""
    fi
}


function backlight() {
    if [ $# != 1 ]; then
        echo $# "arguments received; expected 1"
        return 1
    fi
    if [[ $1 != 0 && $1 != 1 && $1 != 2 ]]; then
        echo "invalid arg:" $1
        echo "argument must be 0, 1, or 2"
        return 1
    fi
    brightnessctl --device='tpacpi::kbd_backlight' set $1
}

function extend() {
    if [ $# != 1 ]; then
        echo $# "arguments received; expected 1"
        return 1
    fi
    if [[ $1 != "left" && $1 != "right" ]] && [ $1 != "reset" ]; then
        echo "invalid arg:" $1
        echo "argument must be \"left\" or \"right\" or \"reset\""
        return 1
    fi
    BG_PATH=$HOME/.config/nitrogen/bg-saved.cfg
    BG=$(awk -F '=' '/file=/{print $2}' $BG_PATH)
    echo $BG
    if [ $1 == "left" ]; then
        xrandr --output eDP-1 --output HDMI-1 --left-of eDP-1 --auto
        echo 'awesome.restart()' | awesome-client
        killall polybar
        sleep 1
        nitrogen --set-zoom-fill --head=1 $BG &
        sleep 1
        nitrogen --set-zoom-fill --head=0 $BG &
        sleep 1
        polybar &
    fi
    if [ $1 == "right" ]; then
        xrandr --output eDP-1 --output HDMI-1 --right-of eDP-1 --auto
        echo 'awesome.restart()' | awesome-client
        killall polybar
        sleep 1
        nitrogen --set-zoom-fill --head=1 $BG &
        sleep 1
        nitrogen --set-zoom-fill --head=0 $BG &
        sleep 1
        polybar &
    fi
    if [ $1 == "reset" ]; then
        # should find a way to detect screen quantity and only trigger then
        xrandr --output eDP-1 --output HDMI-1 --left-of eDP-1 --auto
        echo 'awesome.restart()' | awesome-client
        killall polybar
        sleep 1
        nitrogen --restore &
        sleep 1
        polybar &
    fi
}

function extbg() {
    if [ $# != 0 ]; then
        echo $# "arguments received; expected 1"
        return 1
    fi
    BG_PATH=$HOME/.config/nitrogen/bg-saved.cfg
    BG=$(awk -F '=' '/file=/{print $2}' $BG_PATH)
    nitrogen --set-zoom-fill --head=0 $BG &
    nitrogen --set-zoom-fill --head=1 $BG &
}


# User defined aliases

alias lock="xsecurelock"
alias copydir="pwd | xclip -selection clipboard"


# User defined environment variables

## XSecureLock

export XSECURELOCK_SHOW_DATETIME="1"
export XSECURELOCK_PASSWORD_PROMPT="asterisks"
export XSECURELOCK_AUTH_FOREGROUND_COLOR="Cyan"

## Other environment variables

export XCOMPOSEFILE="$HOME/.XCompose"

# Zoxide and statusline

MAGENTA='\033[1;95m'
NC='\033[0m' # No Color
export _ZO_ECHO=1
eval "$(zoxide init --cmd cd bash)"

# colored pwd output
# alias pwd="echo -e '${MAGENTA}$PWD${NC}'"



# Haskell

[ -f "/home/cyz/.ghcup/env" ] && source "/home/cyz/.ghcup/env" # ghcup-env


