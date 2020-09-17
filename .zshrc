# Emacs fix
if [[ "$TERM" == "dumb" ]]; then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    if whence -w precmd >/dev/null; then
        unfunction precmd
    fi
    if whence -w preexec >/dev/null; then
        unfunction preexec
    fi
    PS1='$ '

else
    # Environment Variables
    export LANG=ja_JP.UTF-8

    # Settings about history
    HISTFILE=~/.zsh_history
    HISTSIZE=100000
    SAVEHIST=100000
    # Ignore command duplicates
    setopt hist_ignore_dups
    # Ignore all of command duplicates
    setopt hist_ignore_all_dups
    # share history among zsh instances
    setopt share_history

    # Auto complete
    autoload -Uz compinit
    compinit -u
    if [ -e /usr/local/share/zsh-completions ]; then
        fpath=(/usr/local/share/zsh-completions $fpath)
    fi
    # Enable complete for capital letter
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    # Display packed lists & colored lists
    setopt list_packed
    zstyle ':completion:*' list-colors ''

    # Enable typo correction 
    setopt correct
    # Eliminate beep
    # setopt no_beep

    # prompt
    autoload -Uz vcs_info
    setopt prompt_subst
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
    zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
    zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
    zstyle ':vcs_info:*' actionformats '[%b|%a]'
    precmd() { vcs_info }
    PROMPT='%m:%F{green}%~%f %n %F{yellow}$%f '
    RPROMPT='${vcs_info_msg_0_}'

    # alias
    alias ls='ls -aF'
    alias ll='ls -l'
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    alias vi='vim'
    alias cat='cat'
    alias less='less -NM'
    export CLICOLOR=1
    export LSCOLORS=DxGxcxdxCxegedabagacad

    # End Emacs Fix
fi

# path
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
