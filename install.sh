#!/bin/bash
set -e

echo "Installing power management tools..."

sudo pacman -S --noconfirm tlp powertop thermald macfanctld

echo "Enabling services..."
sudo systemctl enable --now tlp.service
sudo systemctl enable --now thermald.service
sudo systemctl enable --now macfanctld.service
sudo systemctl enable --now powertop-tune.service
sudo systemctl enable --now reoptimize-macbook.timer

echo "Copying systemd units and hook..."
sudo cp systemd/*.service /etc/systemd/system/
sudo cp systemd/*.timer /etc/systemd/system/
sudo cp pacman-hook/reoptimize-macbook.hook /etc/pacman.d/hooks/
sudo cp tlp.conf /etc/tlp.conf

echo "Reloading systemd and restarting TLP..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart tlp.service

echo "Installation complete."
