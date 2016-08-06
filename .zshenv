os_x () {
    # Use bsd-style ls to get colors
    alias ls='ls -hG'

    # Prefer local bins -- homebrew makes use of this
    PATH=/usr/local/sbin:/usr/local/bin:$PATH
    export PATH

    # Check for iterm shell integrations and source if there
    if [[ -e $HOME/.iterm2_shell_integration.zsh ]]; then
        source $HOME/.iterm2_shell_integration.zsh
    fi

}

# Set vars for golang
golang_settings () {
    export GO_ENV=~/.goenvs
    # GOPATH=$HOME/go
    # export GOPATH
    # PATH=$PATH:$HOME/go/bin
    # export PATH
}

# Set vars for nvm
nvm_settings () {
    export NVM_DIR=$HOME/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
}

rbenv_settings() {
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)";
}

local_path() {
    # Always prefer local installed bins
    PATH=$HOME/.local/bin:$PATH
    export PATH
}
# Machine specific configurations...

if [[ "$HOST" == 'zero' ]]; then
    # OS X machine
    os_x;
    rbenv_settings;
    nvm_settings;
    golang_settings;
    # *sigh* this should be a part of golang_settings, need to check host there too though then :/
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
    local_path;
    # GPG Section FIXME: move to fn
    gpg_agent_running=$(pgrep gpg-agent)
    if [[ -z ${gpg_agent_running} ]]; then
        gpg-agent --daemon --enable-ssh-support -s --write-env-file "${HOME}/.gpg-agent-info"
    fi

    if [[ -f "${HOME}/.gpg-agent-info" ]]; then
        . "${HOME}/.gpg-agent-info"
        export GPG_AGENT_INFO
        export SSH_AUTH_SOCK
    fi
    GPG_TTY=$(tty)
    export GPG_TTY

else
    if [[ "$HOST" == 'telser-mbp' ]]; then
        os_x;
        rbenv_settings;
        nvm_settings;
        local_path;
    fi
fi

if [[ "$HOST" == 'signas' || "$HOST" == 'sigma' ]]; then
  local_path;
  PATH=$PATH:$HOME/.cabal/bin:$HOME/.conscript/bin
  export PATH

  # GPG Section FIXME: move to fn
  gpg_agent_running=$(pgrep gpg-agent)
  if [[ -z ${gpg_agent_running} ]]; then
      gpg-agent --daemon --enable-ssh-support -s #--write-env-file "${HOME}/.gpg-agent-info"
  fi

  GPG_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent"
  SSH_AGENT_INFO="${HOME}/.gnupg/S.gpg-agent"
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK

  GPG_TTY=$(tty)
  export GPG_TTY

  rbenv_settings;
  alias brake=bundle exec rake
  PHANTOMJS_BIN=/usr/local/bin/phantomjs
  export PHANTOMJS_BIN

fi

if [[ "$HOST" == 'chuck' ]]; then
    export PATH=/usr/pkg/bin:/usr/pkg/sbin:/usr/bin:/usr/sbin:$PATH
fi
