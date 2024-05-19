set -e

sudo pacman -S reflector
sudo reflector -p https --sort score --save /etc/pacman.d/mirrorlist
sudo pacman -R reflector

sudo pacman -Syu
sudo pacman -S bash-completion btop chromium discord docker docker-buildx docker-compose \
    fastfetch ghostty git go man-db neovim nvm starship unzip vlc wl-clipboard zip

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/ && makepkg -si
cd ../ && rm -rf yay-bin/
yay -S brave-bin zen-browser-bin

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo systemctl disable NetworkManager-wait-online
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

ln -s $HOME/repos/dotfiles/.config/nvim $HOME/.config/nvim
ln -s .bashrc $HOME/.bashrc
ln -s .gitconfig $HOME/.gitconfig
