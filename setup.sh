sudo pacman -S reflector
sudo reflector -p https --sort score --save /etc/pacman.d/mirrorlist
sudo pacman -R reflector

sudo pacman -Syu
sudo pacman -S bash-completion btop chromium docker \
    docker-buildx docker-compose fastfetch ghostty git go \
    man-db neovim nvm starship unzip wl-clipboard zip

sudo systemctl enable --now docker
sudo usermod -aG docker $USER

ln -s $HOME/repos/dotfiles/.config/nvim/ $HOME/.config/nvim
cat .bashrc > $HOME/.bashrc
cat .gitconfig > $HOME/.gitconfig

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin/ && makepkg -si
cd ../ && rm -rf yay-bin/
yay -S brave-bin 

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
