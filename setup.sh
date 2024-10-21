#!/bin/bash

# Function to install zsh and set as default shell
install_zsh() {
    echo "Installing Zsh..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update
        sudo apt install -y zsh
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    fi
    
    # Set Zsh as the default shell
    chsh -s $(which zsh)
    echo "Zsh installed and set as default shell."
}

# Function to add aliases to .zshrc and .bashrc
add_aliases() {
    echo "Adding aliases to .zshrc and .bashrc..."
    ALIASES='
function cheat() {
curl cheat.sh/$1
}

# Example aliases
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -lAh --color=auto"
alias ip="ip -c"

alias dna="/usr/bin/dig +noall +answer"
alias ds="/usr/bin/dig +short"

alias gcb='git branch | fzf | cut -c 3- | xargs git checkout'
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias GH="cd ~/documents/github"
alias adb="/Users/$USER/Documents/platform-tools/adb"
alias dy="dig +short @dns.toys"
alias k="kubectl"
alias kgp="clear && kubectl get pods"


alias ll="ls -la"
alias gs="git status"
alias gp="git pull"
alias gd="git diff"

'
    
    # Add aliases to .zshrc
    if [[ -f "$HOME/.zshrc" ]]; then
        if ! grep -q "alias ll=" "$HOME/.zshrc"; then
            echo "$ALIASES" >> "$HOME/.zshrc"
        fi
    else
        echo "$ALIASES" > "$HOME/.zshrc"
    fi

    # Add aliases to .bashrc
    if [[ -f "$HOME/.bashrc" ]]; then
        if ! grep -q "alias ll=" "$HOME/.bashrc"; then
            echo "$ALIASES" >> "$HOME/.bashrc"
        fi
    else
        echo "$ALIASES" > "$HOME/.bashrc"
    fi
    
    echo "Aliases added."
}

# Run functions
install_zsh
add_aliases

echo "Setup complete!"
