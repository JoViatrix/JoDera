#!/bin/bash

set -ouex pipefail

echo "Setting up ntsync"

cat >/etc/modules-load.d/ntsync.conf <<EOF
ntsync
EOF



