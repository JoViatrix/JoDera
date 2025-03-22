#!/bin/bash

set -ouex pipefail

echo "Installing acer-wmi-battery"

dnf5 -y copr enable asan/acer-modules

RELEASE="$(rpm -E %fedora)"
KERNEL_FLAVOR=main
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

skopeo copy docker://ghcr.io/joviatrix/akmods-extra:"${KERNEL_FLAVOR}"-"${RELEASE}"-"${QUALIFIED_KERNEL}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/

rpm-ostree install acer-wmi-battery /tmp/rpms/kmods/*acer-wmi-battery*.rpm

cat >/etc/modules-load.d/acer-wmi-battery.conf <<EOF
acer-wmi-battery
EOF

cat >/etc/modprobe.d/acer-wmi-battery.conf <<EOF
options acer-wmi-battery enable_health_mode=1
EOF

dnf5 copr remove asan/acer-modules



