autoload -Uz vcs_info
autoload -Uz promptinit && promptinit
setopt prompt_subst
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*' formats       '%F{14}[%F{4}%b%F{14}]%f'
zstyle ':vcs_info:*' actionformats '%F{14}[%F{4}%b%F{14}%F{14}] (%F{9}%a%F{14})%f'

precmd () { vcs_info }
PROMPT="%F{6}%~%F{14} %#%f "
RPS1=' '
RPROMPT='${vcs_info_msg_0_}'
