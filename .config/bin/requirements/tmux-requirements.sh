#!/bin/bash

# A script to set up the tmux environment automatically.

echo "🚀 Starting tmux environment setup..."

# Define the path to the TPM directory
TPM_DIR="$HOME/.tmux/plugins/tpm"

# --- Step 1: Install TPM (Tmux Plugin Manager) ---
if [ ! -d "$TPM_DIR" ]; then
    echo "🛠️ TPM not found. Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    if [ $? -eq 0 ]; then
        echo "✅ TPM installed successfully."
    else
        echo "❌ Error: Failed to clone TPM repository. Please check your internet connection and git installation."
        exit 1
    fi
else
    echo "👍 TPM is already installed."
fi

# --- Step 2: Create Symbolic Link for .tmux.conf ---
# Assumes this script is run from the root of the 'linux-config' repository.
CONFIG_DIR=$(pwd)

echo "🔗 Creating symbolic link for .tmux.conf..."
ln -sf "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
echo "  -> Linked .tmux.conf"

# --- Step 3: Install Tmux Plugins ---
echo "🔌 Installing Tmux plugins using TPM..."
# This command automatically installs the plugins listed in your .tmux.conf
"$TPM_DIR/bin/install_plugins"
echo "✅ Tmux plugins installed."

echo "🎉 All done! Your tmux environment is ready. Start a new tmux session to see the changes."
