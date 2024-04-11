#!/bin/bash

desired_shell="/usr/local/bin/zsh-5.6.2"

# Check if the desired shell is in the list of available shells

# Check if desired shell is in the list of available shells
if chsh -l | grep -q "$desired_shell"; then
    echo "$desired_shell is available."
else
    echo "$desired_shell is not available."
    sudo bash ./install_zsh-5.6.2.sh $USER
fi

# Install Oh My Zsh non-interactively (without changing the default shell)
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone the Powerlevel10k theme if it doesn't exist
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	# Check and update ZSH_THEME
	if grep -q '^ZSH_THEME=".*"' "$ZSHRC"; then
	    # ZSH_THEME exists, change it to powerlevel10k/powerlevel10k
	    sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
	else
	    # ZSH_THEME does not exist, add it
	    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
	fi
fi

# Clone zsh-autosuggestions plugin if it doesn't exist
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

# Clone zsh-syntax-highlighting plugin if it doesn't exist
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Function to check and add plugin if not exists
add_plugin_if_not_exists() {
    local plugin=$1
    if ! grep -q "$plugin" "$ZSHRC"; then
        # Plugin not found, add it
        sed -i "/^plugins=(/s/)$/ $plugin)/" "$ZSHRC"
    fi
}

# Ensure plugins array exists
if grep -q '^plugins=(.*)' "$ZSHRC"; then
    # Check each plugin and add if it doesn't exist
    add_plugin_if_not_exists "zsh-syntax-highlighting"
    add_plugin_if_not_exists "zsh-autosuggestions"
else
    # plugins array doesn't exist, add it with the required plugins
    echo '
plugins=( 
    zsh-syntax-highlighting
    zsh-autosuggestions
)
' >> "$ZSHRC"
fi

