#!/bin/bash

set -ouex pipefail

echo "Installing xpadneo"

dnf5 -y copr enable atim/xpadneo

RELEASE="$(rpm -E %fedora)"
KERNEL_FLAVOR=main
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

skopeo copy docker://ghcr.io/joviatrix/akmods:"${KERNEL_FLAVOR}"-"${RELEASE}"-"${QUALIFIED_KERNEL}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/

dnf5 install -y xpadneo /tmp/rpms/kmods/*xpadneo*.rpm

cat >/etc/modules-load.d/xpadneo.conf <<EOF
hid_xpadneo
EOF

dnf5 copr remove atim/xpadneo



