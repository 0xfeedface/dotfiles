# Use modern completion system
autoload -Uz compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:approximate:*' max-errors 3
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*:messages' format '%F{2} -- %d -- %F{14}'
zstyle ':completion:*:messages' format "%F{2} -- %d -- %F{14}"
zstyle ':completion:*:warnings' format "%F{1} -- no matches found -- %F{14}"
zstyle ':completion:*:descriptions' format "%F{2} -- %d -- %F{14}"
zstyle ':completion:*:corrections' format "%F{2} -- %d -- %F{14}"


# zsh parameter completion for the dotnet CLI
if type dotnet > /dev/null; then
  _dotnet_zsh_complete() {
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
  }
  compdef _dotnet_zsh_complete dotnet
fi

if type kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi
