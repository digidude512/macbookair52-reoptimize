#!/bin/bash

LOG="/var/log/reoptimize-macbook.log"
TIME=$(date "+%Y-%m-%d %H:%M:%S")
HOST=$(hostname)

echo "🔧 Reoptimization started at $TIME on $HOST" | tee "$LOG"

echo -e "\n🧰 Rebuilding GRUB..." | tee -a "$LOG"
sudo grub-mkconfig -o /boot/grub/grub.cfg | tee -a "$LOG"

echo -e "\n🧪 Current kernel command line:" | tee -a "$LOG"
cat /proc/cmdline | tee -a "$LOG"

echo -e "\n📦 Ensuring thermal modules are loaded..." | tee -a "$LOG"
sudo modprobe coretemp applesmc
echo -e "coretemp\napplesmc" | sudo tee /etc/modules-load.d/thermal.conf

echo -e "\n🔁 Regenerating initramfs..." | tee -a "$LOG"
sudo mkinitcpio -P | tee -a "$LOG"

SERVICES=(thermald auto-cpufreq macfanctld)
echo -e "\n🚦 Restarting and enabling services..." | tee -a "$LOG"
for svc in "${SERVICES[@]}"; do
    echo "🔄 $svc" | tee -a "$LOG"
    sudo systemctl restart "$svc.service"
    sudo systemctl enable "$svc.service"
    systemctl is-active "$svc.service" && echo "✅ $svc is active" || echo "❌ $svc failed to start" | tee -a "$LOG"
done

echo -e "\n⚙️ auto-cpufreq live info:" | tee -a "$LOG"
sudo auto-cpufreq --live | tee -a "$LOG"

echo -e "\n🌬️ macfanctld recent log:" | tee -a "$LOG"
journalctl -u macfanctld -n 20 --no-pager | tee -a "$LOG"

echo -e "\n🔋 powertop tunables:" | tee -a "$LOG"
sudo powertop --auto-tune
sudo powertop --html
echo "🔗 HTML report generated: $(realpath powertop.html)" | tee -a "$LOG"

echo -e "\n📎 Loaded modules:" | tee -a "$LOG"
lsmod | grep -E 'coretemp|applesmc' | tee -a "$LOG"

echo -e "\n✅ Reoptimization complete at $(date)" | tee -a "$LOG"

if command -v notify-send &> /dev/null && [ "$DISPLAY" ]; then
    notify-send "✅ Reoptimization Complete" "MacBook performance + thermal tuning has been applied." --icon=system-run
fi
