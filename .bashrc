# List
alias ls='ls --color=auto'
alias l='ls'
alias la='ls -a'
alias ll='ls -la'

# Software managment
alias mirror='sudo reflector --country Argentina,Brazil,Chile --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syyu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'

# Neovim
alias vim='nvim'
export VISUAL=nvim
export EDITOR=nvim

# Rust
. "$HOME/.cargo/env"

eval "$(starship init bash)"
