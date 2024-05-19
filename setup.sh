sudo pacman -S reflector
sudo reflector -p https --sort score --save /etc/pacman.d/mirrorlist
sudo pacman -R reflector

sudo pacman -Syu
sudo pacman -S bash-completion btop chromium docker docker-buildx docker-compose fastfetch \
    ghostty git go less man-db neovim noto-fonts noto-fonts-cjk noto-fonts-emoji \
    npm ripgrep spectacle starship tar unzip wget wl-clipboard zip

cd $HOME && git clone https://aur.archlinux.org/yay.git
cd $HOME/yay && makepkg -si
cd $HOME && rm -rf yay/
cd $HOME && git clone https://aur.archlinux.org/brave-bin.git
cd $HOME/brave-bin && makepkg -si
cd $HOME && rm -rf brave-bin/

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo systemctl enable --now docker
sudo usermod -aG docker $USER
