local_path() {
    # Always prefer ~/.local installed bins
    PATH=$HOME/.local/bin:$PATH
    export PATH
}

gpg_agent() {

  # GPG Section FIXME: move to fn
  gpg_agent_running=$(pgrep gpg-agent)
  if [[ -z ${gpg_agent_running} ]]; then
      gpg-agent --daemon --enable-ssh-support -s #--write-env-file "${HOME}/.gpg-agent-info"
  fi

  GPG_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent"
#  SSH_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent"
  export GPG_AGENT_INFO
#  export SSH_AUTH_SOCK

  GPG_TTY=$(tty)
  export GPG_TTY
}

local_pkgsrc_path() {
  # make sure that pkgsrc dirs /usr/pkg/{bin,sbin} are on PATH
  PATH=$PATH:~/pkg/sbin:~/pkg/bin
  export PATH
}

pkgsrc_path() {
  # make sure that pkgsrc dirs /usr/pkg/{bin,sbin} are on PATH
  PATH=$PATH:/usr/pkg/sbin:/usr/pkg/bin
  export PATH
}

# Defaults..
ZBG=124

# Machine specific configurations...

if [[ "$HOST" == 'zero' ]]; then
  ZBG=034
  local_path;
  # cabal path, prefer it over even .local from stack..
  PATH=/sbin:$PATH
  pkgsrc_path;
  local_pkgsrc_path;
  gpg_agent;
  alias spotify='spotify --force-device-scale-factor=2'
  alias antoine='mosh antoine'
  alias chuck='mosh nack ssh chuck'
  alias dev='mosh dev'
  alias nack='mosh nack'
  alias rabot='mosh rabot'
  alias sally='mosh sally'
  export GDK_SCALE=2
  alias vboxmanage=VBoxManage
  alias thc-caltest='rm -r ~/.thc obj  && make clean && make && make libs && ./thc examples/Calendar.hs -o cal && ./cal 2019'
#  alias slack='~/progs/slack/usr/bin/slack'
#  alias robo3t='~/progs/robo3t-1.1.1-linux-x86_64-c93c6b0/bin/robo3t'
fi

if [[ "$HOST" == 'antione' ]]; then
    ZBG=094
fi

if [[ "$HOST" == 'chuck.silencedpoet.com' ]]; then
    ZBG=020
    export PATH=/usr/pkg/bin:/usr/pkg/sbin:/usr/bin:/usr/sbin:$PATH
fi

if [[ "$HOST" == 'nack.silencedpoet.com' ]]; then
    ZBG=172
fi

if [[ "$HOST" == 'sally.silencedpoet.com' ]]; then
    ZBG=039
fi

if [[ "$HOST" == 'rabot.silencedpoet.com' ]]; then
    ZBG=206
fi

if [[ "$HOST" == 'dev.silencedpoet.com' ]]; then
    ZBG=128
    local_path;
fi

if [[ "$HOST" == 'work' ]]; then
    ZBG=120
    local_path;
fi

# On all machines export the zsh theme color code..
export ZBG

PATH=$PATH:~/progs/cask/bin:~/.cabal/bin/
export PATH=/home/trevis/node_modules/.bin:$PATH
alias work-vm-up='vboxmanage startvm work --type headless'
alias work-alpine-vm-up='vboxmanage startvm alpine_work --type headless'
alias work-devuan-vm-up='vboxmanage startvm work-devuan --type headless'
SCHMODS_DIR='cd ~/work/schmods;'
COMP_UP='docker-compose up -d;'
ZSHI='/usr/bin/zsh -i'
API='./tasks/attach api;'
APP='./tasks/attach app;'
API_SESS="$SCHMODS_DIR $COMP_UP $API $ZSHI"
APP_SESS="$SCHMODS_DIR sleep 20; $APP $ZSHI"
SCHMODS_CMD="tmux new-session -d \"$API_SESS\" \; split-window \"$APP_SESS\" \; attach"
TMUX_CMD="tmux new-session -d \"$ZSHI\" \; split-window \"$ZSHI\" \; attach"

alias work="ssh -t -p 2222 trevis@localhost"
alias work-alpine="ssh -t -p 2223 trevis@localhost"
alias work-devuan="ssh -t -p 2224 trevis@localhost"
alias work-tmux="ssh -t -p 2222 trevis@localhost '$TMUX_CMD'"
alias work-emacs="ssh -t -p 2222 trevis@localhost '$SCHMODS_DIR emacs; $ZSHI'"
alias work-emacs-term="nohup xterm -e zsh -i -c 'work-emacs; zsh'"
alias work-up='work-vm-up; sleep 120; work-tmux'
alias apu2-screen="sudo screen /dev/ttyUSB0 115200"
