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

# Defaults..
ZBG=124

# Machine specific configurations...

if [[ "$HOST" == 'zero-ubuntu' ]]; then
  ZBG=143
  local_path;
  gpg_agent;
  alias spotify='spotify --force-device-scale-factor=2'
  alias antoine='mosh antoine'
  alias chuck='mosh nack ssh chuck'
  alias dev='mosh dev'
  alias nack='mosh nack'
  alias rabot='mosh rabot'
  alias sally='mosh sally'
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

if [[ "$HOST" == 'dev_jail' ]]; then
    ZBG=128
    local_path;
fi

# On all machines export the zsh theme color code..
export ZBG
