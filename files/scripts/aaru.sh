#!/bin/bash

set -ouex pipefail

echo "Installing aaru"

REPO="aaru-dps/Aaru"
ASSET_SUFFIX=".el.x86_64.rpm"
RELEASE_DATA=$(curl -s "https://api.github.com/repos/$REPO/releases" | jq -r '[.[] | select(.prerelease == true)][0]')
ASSET_NAME=$(echo "$RELEASE_DATA" | jq -r ".assets[] | select(.name | endswith(\"$ASSET_SUFFIX\")) | .name")
TAG=$(echo "$RELEASE_DATA" | jq -r '.tag_name')
URL="https://github.com/$REPO/releases/download/$TAG/$ASSET_NAME"
curl -L -o "/tmp/aaru.rpm" "$URL"

rpm-ostree install /tmp/aaru.rpm

mv --update=none-fail /usr/local/bin/aaru /usr/bin/