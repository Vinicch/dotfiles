echo "Updating mirrors..."
sudo pacman -S reflector
sudo reflector --country Argentina,Brazil,Chile --latest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo
echo "Installing packages..."
sudo pacman -Syu
sudo pacman -S alacritty base-devel bash-completion bat btop discord docker docker-buildx docker-compose dust fd firefox git go neovim noto-fonts noto-fonts-cjk noto-fonts-emoji nushell ripgrep starship tar terraform tmux ttf-noto-nerd unrar unzip wget zip

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
echo "Copying dotfiles..."
cp -r .config/alacritty/ $HOME/.config/
cp -r .config/nvim/ $HOME/.config/
cp -r .local/share/bash-completion/ $HOME/.local/share/
cp .bashrc $HOME/.bashrc
cp .gitconfig $HOME/.gitconfig

echo
echo "All done!"
