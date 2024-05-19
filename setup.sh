echo "Updating mirrors..."
sudo pacman -S reflector
sudo reflector -p https --sort score --save /etc/pacman.d/mirrorlist

echo
echo "Installing packages..."
sudo pacman -Syu
sudo pacman -S alacritty base-devel bash-completion bat btop docker docker-buildx \
    docker-compose fd firefox git go less man-db neovim noto-fonts noto-fonts-cjk \
    noto-fonts-emoji ripgrep spectacle starship tar ttf-noto-nerd unzip wget wl-clipboard zip

echo
echo "Installing Brave Browser through the AUR..."
cd $HOME && git clone https://aur.archlinux.org/brave-bin.git
cd $HOME/brave-bin && makepkg -si
cd $HOME && rm -rf brave-bin/
cd $HOME && git clone https://aur.archlinux.org/yay.git
cd $HOME/yay && makepkg -si
cd $HOME && rm -rf yay/

echo
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo
echo "Configuring Docker..."
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

echo
echo "All done!"
