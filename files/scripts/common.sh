#!/bin/bash

set -ouex pipefail

echo "Installing common libraries"

RELEASE="$(rpm -E %fedora)"

rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

#dnf5 group install -y multimedia --allowerasing
dnf5 install -y --allowerasing alsa-ucm alsa-utils gstreamer1-plugin-dav1d gstreamer1-plugin-libav gstreamer1-plugins-bad-free gstreamer1-plugins-good gstreamer1-plugins-ugly-free libva-intel-media-driver pipewire-alsa pipewire-gstreamer pipewire-pulseaudio pipewire-utils wireplumber

rpm-ostree uninstall rpmfusion-free-release rpmfusion-nonfree-release