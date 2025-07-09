# hyprland launch
if ! pgrep hyprland &> /dev/null; then
    source ~/.config/hypr/scripts/mon_select.zsh
    hyprland
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt nomatch notify
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 5
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' special-dirs true
zstyle :compinstall filename '/home/sct/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by chrisott0
export LS_COLORS="$(vivid generate gruvbox-dark-hard)"
export EDITOR=nvim
export PATH=$PATH:$HOME/.cargo/bin

alias ls='ls -a --color'

autoload -Uz vcs_info
setopt PROMPT_SUBST
precmd() { 
  vcs_info
  zstyle ':vcs_info:git:*' formats '%b '
  print -rP '%F{yellow}[ %n@%m ] %F{yellow}%*%f %F{yellow}%(5~|%-1~/…/%3~|%4~)%f %F{red}${vcs_info_msg_0_}%f'
  PROMPT='%F{yellow}~>=%f '
}

# wrappers, funcs, machine specific configurations
if [ ! -d $HOME/.config/zsh ]; then
  mkdir -p $HOME/.config/zsh
fi

if [ ! -f $HOME/.config/zsh/environment.zsh ]; then
	touch $HOME/.config/zsh/environment.zsh
fi

for f in $HOME/.config/zsh/*; do
  source "$f"
done
clear

# End of lines configured by chrisott0

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
