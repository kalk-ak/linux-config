#!/bin/bash

# A script to set up the linux-config environment automatically.

echo "🚀 Starting environment setup..."

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

# --- Step 2: Create Symbolic Links for Config Files ---
# Assumes this script is run from the root of the 'linux-config' repository.
CONFIG_DIR=$(pwd)

echo "🔗 Creating symbolic links for configuration files..."

# Link .tmux.conf
ln -sf "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
echo "  -> Linked .tmux.conf"

# Link NeoVim config
mkdir -p "$HOME/.config"
ln -sf "$CONFIG_DIR/.config/nvim" "$HOME/.config/nvim"
echo "  -> Linked .config/nvim"

# --- Step 3: Install Tmux Plugins ---
echo "🔌 Installing Tmux plugins using TPM..."
# Start a temporary tmux server, install plugins, and then kill the server
# This prevents the need to manually start tmux and press Prefix + I
"$TPM_DIR/bin/install_plugins"
echo "✅ Tmux plugins installed."

# --- Step 4: Install NeoVim Plugins ---
echo "🐘 Installing NeoVim plugins..."
# We use --headless to install plugins without opening the UI
# The 'qa' command quits all windows when done.
nvim --headless "+Lazy! sync" +qa
echo "✅ NeoVim plugins installed/updated."


echo "🎉 All done! Your environment is ready. Start a new tmux session to see the changes."


