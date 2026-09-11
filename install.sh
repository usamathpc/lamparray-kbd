#!/bin/sh
# Installs lamparray-kbd for the current user + a udev rule (needs sudo once).
set -e
cd "$(dirname "$0")"
BIN="$HOME/.local/bin"; UNITS="$HOME/.config/systemd/user"
mkdir -p "$BIN" "$UNITS"
install -m 755 lamparray-kbd "$BIN/lamparray-kbd"
install -m 644 systemd/lamparray-kbd-restore.service "$UNITS/"
systemctl --user daemon-reload
systemctl --user enable lamparray-kbd-restore.service
echo "==> installing udev rule for detected devices (sudo)"
sudo "$BIN/lamparray-kbd" install-udev
echo "==> done. Try:  lamparray-kbd list   /   lamparray-kbd solid 00a0ff"
case ":$PATH:" in *":$BIN:"*) ;; *) echo "note: add $BIN to your PATH";; esac
