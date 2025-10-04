#!/bin/bash

set -ouex pipefail

echo "Installing bitwarden"

curl -L -o "/tmp/bitwarden.rpm" 'https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm'


rpm-ostree install /tmp/bitwarden.rpm

cat >/usr/lib/tmpfiles.d/bitwarden.conf <<EOF
L /opt/Bitwarden - - - - /usr/lib/opt/Bitwarden
EOF