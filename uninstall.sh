#!/bin/sh
systemctl --user disable --now lamparray-kbd-restore.service 2>/dev/null
rm -f "$HOME/.config/systemd/user/lamparray-kbd-restore.service" "$HOME/.local/bin/lamparray-kbd"
systemctl --user daemon-reload
sudo rm -f /etc/udev/rules.d/70-lamparray-kbd.rules && sudo udevadm control --reload-rules
echo "removed (config left in ~/.config/lamparray-kbd)"
