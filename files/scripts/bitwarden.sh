#!/bin/bash

set -ouex pipefail

echo "Installing bitwarden"

curl -L -o "/tmp/bitwarden.rpm" 'https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm'


mkdir -p /var/opt
rpm-ostree install /tmp/bitwarden.rpm
mv /opt/Bitwarden /usr/lib/opt/Bitwarden

cat >/usr/lib/tmpfiles.d/bitwarden.conf <<EOF
L /opt/Bitwarden - - - - /usr/lib/opt/Bitwarden
EOF