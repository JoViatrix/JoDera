# Create if non-existing and enable python venv
if [ ! -f "$HOME/.venv/bin/activate" ]; then
    python3 -m venv "$HOME/.venv"
fi
source "$HOME/.venv/bin/activate"
