#!/bin/bash

echo "🔄 Backing up config files..."
sudo cp /etc/tlp.conf ~/tlp.conf.backup 2>/dev/null || echo "No existing /etc/tlp.conf"
sudo cp /usr/local/bin/reoptimize-macbook.sh ~/reoptimize-macbook.sh.backup 2>/dev/null || echo "No existing reoptimize script"

echo "🛑 Stopping and disabling old services/timers..."
sudo systemctl disable --now powertop-tune.service 2>/dev/null
sudo systemctl disable --now reoptimize-macbook.timer 2>/dev/null
sudo systemctl disable --now reoptimize-macbook.service 2>/dev/null

echo "🗑️ Removing old systemd unit files..."
sudo rm -f /etc/systemd/system/powertop-tune.service
sudo rm -f /etc/systemd/system/reoptimize-macbook.service
sudo rm -f /etc/systemd/system/reoptimize-macbook.timer

echo "🧹 Removing old hook and script..."
sudo rm -f /etc/pacman.d/hooks/reoptimize-macbook.hook
sudo rm -f /usr/local/bin/reoptimize-macbook.sh

echo "✅ Clean-up complete. You can now run ./install.sh safely."
