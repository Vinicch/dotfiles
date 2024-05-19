echo "Updating mirrors..."
sudo pacman -S reflector
sudo reflector -c Chile -p https --sort rate --save /etc/pacman.d/mirrorlist

echo
echo "Installing packages..."
sudo pacman -Syu
sudo pacman -S alacritty base-devel bash-completion bat btop docker docker-buildx \
    docker-compose fd firefox git go less man-db neovim noto-fonts noto-fonts-cjk \
    noto-fonts-emoji ripgrep starship tar terraform ttf-noto-nerd unzip wget wl-clipboard zip

echo
echo "Installing Brave Browser through the Paru AUR helper..."
cd $HOME && git clone https://aur.archlinux.org/paru-bin.git
cd $HOME/paru-bin && makepkg -si
cd $HOME && rm -rf paru-bin/
paru -S brave-bin

echo
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo
echo "Configuring Docker..."
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

echo
echo "All done!"
