#!/bin/bash

bash ./install_zsh-5.6.2.sh
exec zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
exec zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "ZSH_THEME="powerlevel10k/powerlevel10k"" >> ~/.zshrc
exec zsh
p10k configure
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
echo '
plugins=( 
    zsh-syntax-highlighting
    zsh-autosuggestions
)
' >> ~/.zshrc
exec zsh