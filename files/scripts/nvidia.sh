#!/bin/bash

set -ouex pipefail

echo "Installing Nvidia drivers"

RELEASE="$(rpm -E %fedora)"

rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

KERNEL_FLAVOR=main
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

skopeo copy docker://ghcr.io/joviatrix/akmods-nvidia-open:"${KERNEL_FLAVOR}"-"${RELEASE}"-"${QUALIFIED_KERNEL}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/

rpm-ostree install xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda /tmp/rpms/kmods/*kmod-nvidia*.rpm /tmp/rpms/ublue-os/*ublue-os-nvidia-addons*.rpm

rpm-ostree uninstall rpmfusion-free-release rpmfusion-nonfree-release