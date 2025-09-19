#!/bin/bash

set -ouex pipefail

echo "Installing Nvidia drivers"

RELEASE="$(rpm -E %fedora)"

KERNEL_FLAVOR=main
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

skopeo copy docker://ghcr.io/joviatrix/akmods-nvidia:"${KERNEL_FLAVOR}"-"${RELEASE}"-"${QUALIFIED_KERNEL}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/

NVIDIA_VERSION=$(rpm -qp --qf '%{VERSION}' /tmp/rpms/kmods/*kmod-nvidia*.rpm | head -n1)

echo "Detected NVIDIA driver version: $NVIDIA_VERSION"

wget https://negativo17.org/repos/fedora-nvidia.repo -O /etc/yum.repos.d/fedora-nvidia.repo

rpm-ostree install "xorg-x11-nvidia-$NVIDIA_VERSION" \
                   "nvidia-driver-cuda-$NVIDIA_VERSION" \
                   "nvidia-settings-$NVIDIA_VERSION" \
                   /tmp/rpms/kmods/*kmod-nvidia*.rpm \
                   /tmp/rpms/ublue-os/*ublue-os-nvidia-addons*.rpm