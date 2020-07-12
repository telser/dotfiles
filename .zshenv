local_path() {
    # Always prefer ~/.local installed bins
    PATH=$HOME/.local/bin:$PATH
    export PATH
}

gpg_agent() {

  # GPG Section
  gpg_agent_running=$(pgrep gpg-agent)
  if [[ -z ${gpg_agent_running} ]]; then
      eval $(gpg-agent --daemon) # --enable-ssh-support -s #--write-env-file "${HOME}/.gpg-agent-info"
      export SSH_AUTH_SOCK
  fi

  GPG_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent"
#  SSH_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent"
  export GPG_AGENT_INFO

  GPG_TTY=$(tty)
  export GPG_TTY
}

local_pkgsrc_path() {
  # make sure that pkgsrc dirs ~/pkg/{bin,sbin} are on PATH
  PATH=$PATH:~/pkg/sbin:~/pkg/bin
  export PATH
}

pkgsrc_path() {
  # make sure that pkgsrc dirs /usr/pkg/{bin,sbin} are on PATH
  PATH=$PATH:/usr/pkg/sbin:/usr/pkg/bin
  export PATH
}

sbin_path() {
    # make sure that sbin dirs /sbin and /usr/sbin are on PATH because linux is insane
    PATH=/usr/sbin:/sbin:$PATH
    export PATH
}

cask_path() {
    # for emacs have the cask pkg manager installed in ~/progs/cask
    PATH=$PATH:~/progs/cask/bin
    export PATH
}

cabal_path() {
    # for cabal installed programs
    PATH=$PATH:~/.cabal/bin
    export PATH
}

server_aliases() {
    # aliases for mosh into servers
    alias antoine='mosh antoine'
    alias chuck='mosh nack ssh chuck'
    alias dev='mosh dev'
    alias nack='mosh nack'
    alias rabot='mosh rabot'
    alias sally='mosh sally'
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
  cask_path;
  cabal_path;
  gpg_agent;
  server_aliases;
  alias spotify='spotify --force-device-scale-factor=2'
  export GDK_SCALE=2
  alias vboxmanage=VBoxManage
  alias thc-caltest='rm -r ~/.thc obj && make clean && make && make libs && ./thc --no-cache examples/Calendar.hs -o cal && ./cal 2019'
fi

if [[ "$HOST" == 'magmadragoon' ]]; then
  ZBG=061
  local_path;
  sbin_path;
  cask_path;
  cabal_path;
  server_aliases;
  gpg_agent;
  alias thc-caltest='rm -r ~/.thc obj && make clean && make && make libs && ./thc --no-cache examples/Calendar.hs -o cal && ./cal 2019'
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
    export EDITOR=mg
    export PROJECT_DIR=~/work/heb/chedr-core
fi

# On all machines export the zsh theme color code..
export ZBG

alias work-old="ssh -t -p 2224 trevis@localhost"
alias work="ssh -X -t -p 2225 trevis@localhost"
alias work-chedr="work 'cd work/heb/chedr-core && exec \$SHELL -l'"
alias apu2-screen="sudo screen /dev/ttyUSB0 115200"

alias vm-start-work='/usr/bin/qemu-system-x86_64 -monitor none -machine accel=kvm -m 32768 -smp cores=5,threads=2 -hda /home/trevis/vms/work.img -boot once=d,menu=off -net nic -net user,hostfwd=tcp::2225-10.0.2.15:22 -rtc base=utc -display none -name "work" &'

alias vm-start-work-old='/usr/bin/qemu-system-x86_64 -monitor none -machine accel=kvm -m 16384 -smp 8 -hda /home/trevis/.aqemu/work_HDA.img -boot once=c,menu=off -net nic -net user,hostfwd=tcp::2224-10.0.2.15:22 -rtc base=localtime -display none -name "work" &'
