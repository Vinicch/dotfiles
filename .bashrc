export EDITOR="nvim"
export GTK_IM_MODULE="simple"
export PATH="$HOME/.local/bin:$PATH"

. "$HOME/.cargo/env"
source /usr/share/nvm/init-nvm.sh

eval "$(starship init bash)"

alias ls='ls --color=auto'
alias ll='ls -lah'
alias vim='nvim'
alias wreboot='systemctl reboot --boot-loader-entry windows.conf'
