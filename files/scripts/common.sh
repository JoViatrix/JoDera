#!/bin/bash

set -ouex pipefail

echo "Installing common libraries"

RELEASE="$(rpm -E %fedora)"

dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

dnf5 install -y zerotier-one

dnf5 group install -y multimedia

dnf5 remove -y rpmfusion-free-release rpmfusion-nonfree-release