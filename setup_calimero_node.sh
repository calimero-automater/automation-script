#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install curl
install_curl() {
    echo "Installing curl..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y curl
    elif command_exists yum; then
        sudo yum install -y curl
    else
        echo "Error: Package manager not supported. Please install curl manually."
        exit 1
    fi
}

# Function to install Rust
install_rust() {
    echo "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Rust."
        exit 1
    fi
    # Source the Rust environment
    source "$HOME/.cargo/env"
}

# Function to install merod
install_merod() {
    echo "Installing merod..."
    curl -sSf https://raw.githubusercontent.com/calimero-network/core/master/scripts/install-merod.sh | bash
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install merod."
        exit 1
    fi
    # Source the Rust environment
    source "$HOME/.cargo/env"
}

# Check and install curl if not present
if command_exists curl; then
    echo "curl is already installed."
else
    install_curl
fi

# Check and install Rust if not present
if command_exists rustc; then
    echo "Rust is already installed."
else
    install_rust
fi

# Check and install merod if not present
if command_exists merod; then
    echo "merod is already installed."
else
    install_merod
fi

# Variables (modify these as needed)
NODE_NAME="node1"
HOME_DIR="$HOME/.calimero"
SERVER_PORT=2428
SWARM_PORT=2528
PROTOCOL="starknet"  # Replace with your desired protocol

# Create the home directory if it doesn't exist
mkdir -p "$HOME_DIR"

# Initialize the node
echo "Initializing the node..."
merod --node-name "$NODE_NAME" --home "$HOME_DIR" init --server-port "$SERVER_PORT" --swarm-port "$SWARM_PORT" --protocol "$PROTOCOL"
if [ $? -ne 0 ]; then
    echo "Error: Node initialization failed."
    exit 1
fi

# Start the node
echo "Starting the node..."
merod --node-name "$NODE_NAME" --home "$HOME_DIR" run
if [ $? -ne 0 ]; then
    echo "Error: Failed to start the node."
    exit 1
fi

echo "Calimero node setup and running successfully."
