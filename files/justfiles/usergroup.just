add-to-group group:
    @if ! getent group "{{ group }}" >/dev/null; then \
        echo "Group '{{ group }}' does not exist" >&2; \
        exit 1; \
    fi
    @if ! grep -q "^{{ group }}:" /etc/group; then \
        getent group "{{ group }}" | sudo tee -a /etc/group >/dev/null; \
    fi
    @sudo usermod -aG "{{ group }}" "$USER"
    @echo "Added $USER to '{{ group }}'. Restart your computer for it to take effect."
