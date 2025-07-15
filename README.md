# 💻 macbookair52-reoptimize

Power, performance, and thermal tuning scripts for **MacBookAir5,2** running **Arch Linux**.

- ✅ Uses TLP for advanced power management
- ✅ Runs `powertop --auto-tune` on boot
- ✅ Manages fan and thermals with `macfanctld` and `thermald`
- ✅ Auto-reoptimizes after kernel updates via systemd and pacman hook

---

## 🚀 Install

```bash
git clone https://github.com/digidude512/macbookair52-reoptimize.git
cd macbookair52-reoptimize
chmod +x install.sh reoptimize-macbook.sh
sudo ./install.sh
```

---

## 🧼 Cleanup (Optional)

If you've previously installed an older version of the optimization scripts manually, run this first to clean it up safely:

```bash
chmod +x cleanup-old-macbook-opt.sh
./cleanup-old-macbook-opt.sh
```

This will:
- Backup your existing `tlp.conf` and optimization script
- Remove old systemd services/timers
- Remove the pacman hook and reoptimize script

Then re-run the install:

```bash
sudo ./install.sh
```

---

## 🔁 Reoptimization

After every kernel update (or once a week via timer), this script is run:

```bash
/usr/local/bin/reoptimize-macbook.sh
```

It reapplies:
- TLP tuning
- `powertop --auto-tune` runtime settings

---

## 🛠 Enabled Services

| Service/Timer               | Purpose                              |
|----------------------------|--------------------------------------|
| `tlp.service`              | Main power manager                   |
| `thermald.service`         | Thermal protection                   |
| `macfanctld.service`       | Fan control on MacBook               |
| `powertop-tune.service`    | Runtime power savings on boot        |
| `reoptimize-macbook.timer` | Weekly re-tuning                     |
| `reoptimize-macbook.hook`  | Post-kernel-update auto-optimization |

---

## ✅ Done!

You're now running with optimized power, thermal, and fan control on your MacBookAir5,2 running Arch Linux.
