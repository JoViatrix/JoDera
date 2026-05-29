#!/bin/bash

set -ouex pipefail

echo "Installing winboat"

REPO="TibixDev/winboat"
ASSET_SUFFIX="-x86_64.rpm"
RELEASE_DATA=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")
ASSET_NAME=$(echo "$RELEASE_DATA" | jq -r ".assets[] | select(.name | endswith(\"$ASSET_SUFFIX\")) | .name")
TAG=$(echo "$RELEASE_DATA" | jq -r '.tag_name')
URL="https://github.com/$REPO/releases/download/$TAG/$ASSET_NAME"
curl -L -o "/tmp/winboat.rpm" "$URL"

dnf install -y install /tmp/winboat.rpm
