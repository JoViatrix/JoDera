#!/bin/bash

set -ouex pipefail

echo "Installing quarto"

REPO="quarto-dev/quarto-cli"
ASSET_SUFFIX="linux-x86_64.rpm"
RELEASE_DATA=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")
ASSET_NAME=$(echo "$RELEASE_DATA" | jq -r ".assets[] | select(.name | endswith(\"$ASSET_SUFFIX\")) | .name")
TAG=$(echo "$RELEASE_DATA" | jq -r '.tag_name')
URL="https://github.com/$REPO/releases/download/$TAG/$ASSET_NAME"
curl -L -o "/tmp/quarto.rpm" "$URL"


dnf install -y install /tmp/quarto.rpm
