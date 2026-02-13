#!/bin/bash

set -ouex pipefail

echo "Installing vhba"

dnf5 -y copr enable rok/cdemu

RELEASE="$(rpm -E %fedora)"
KERNEL_FLAVOR=main
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

skopeo copy docker://ghcr.io/joviatrix/akmods-extra:"${KERNEL_FLAVOR}"-"${RELEASE}"-"${QUALIFIED_KERNEL}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/

dnf install -y /tmp/rpms/kmods/*vhba*.rpm

cat >/etc/modules-load.d/vhba.conf <<EOF
vhba
EOF

dnf5 copr remove rok/cdemu