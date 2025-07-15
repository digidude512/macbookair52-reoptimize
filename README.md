# MacBook Reoptimize Toolkit

Power and thermal tuning scripts for MacBookAir5,2 on Arch Linux.

## 🔧 Features

- Optimized TLP config for better battery life and thermal control
- powertop --auto-tune integration via systemd
- Thermald + macfanctld enabled
- Weekly reoptimize systemd timer
- Pacman hook for kernel updates

## 📦 Install

```bash
git clone https://github.com/YOURNAME/macbook-reoptimize.git
cd macbook-reoptimize
chmod +x install.sh reoptimize-macbook.sh
sudo ./install.sh
```

## 🛠 Services Enabled

- `tlp.service`
- `thermald.service`
- `macfanctld.service`
- `powertop-tune.service`
- `reoptimize-macbook.timer`

## 📁 Files Installed

- `/etc/tlp.conf`
- `/etc/systemd/system/*.service`
- `/etc/pacman.d/hooks/reoptimize-macbook.hook`
- `/usr/local/bin/reoptimize-macbook.sh`

## ✅ Done!
