#!/bin/bash

# Prompt for the channel with predefined options (using Gum's choose)
channel=$(gum choose "stable" "beta" "alpha" "lts" "custom")

# If custom channel is selected, prompt the user to enter a custom value
if [[ "$channel" == "custom" ]]; then
    channel=$(gum input --placeholder "Enter custom channel")
fi

# Prompt for the version (default is "current")
version=$(gum input --placeholder "Enter version (default: current)" --value "current")

# Prompt for the architecture (choose between aarch64 or x86_64)
machine=$(gum choose "aarch64" "x86_64")

# Initialize architecture variable
arch=""

# Set architecture based on machine type
if [[ $machine == "aarch64" ]]; then
    arch="arm64-usr"
elif [[ $machine == "x86_64" ]]; then
    arch="amd64-usr"
fi

# Adjust the channel if it's one of the valid options
case $channel in
    stable | beta | alpha | lts)
        channel="$channel.release"
        ;;
    *)
        arch="images/${arch%-usr}"
        ;;
esac

# Base URL for downloading Flatcar
base="https://$channel.flatcar-linux.net/${arch}/${version}"

# Fetch the necessary files
echo "Downloading Flatcar production scripts and image..."
wget "$base/flatcar_production_qemu.sh"
wget "$base/flatcar_production_qemu_image.img.bz2"

# Make the script executable
chmod +x flatcar_production_qemu.sh

echo "Download complete and script is now executable."
