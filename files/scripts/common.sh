#!/bin/bash

set -ouex pipefail

echo "Installing common libraries"

RELEASE="$(rpm -E %fedora)"

rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

rpm-ostree install zerotier-one

dnf5 group install -y multimedia

rpm-ostree uninstall rpmfusion-free-release rpmfusion-nonfree-release