# Homelab

## Hardware

### Networking

| Hostname | Device           |
|----------|------------------|
| N/A      | ISP ONT          |
| router   | MikroTik hAP ax3 |

### Servers

| Hostname | Model               | CPU              | GPU          | RAM   | System Storage | Data Storage   | Operating System           |
|----------|---------------------|------------------|--------------|-------|----------------|----------------|----------------------------|
| hp       | HP T620             | AMD GX-217GA     | N/A          | 8GB   | 16GB eMMC      | 480GB USB3 SSD | Debian 13                  |
| rpi      | Raspberry Pi Zero W | Broadcom BCM2835 | N/A          | 512MB | 64GB microSD   | N/A            | Raspberry Pi OS Lite 32bit |
| pve      | Lenovo M900 Tiny    | Intel I5-6500T   | N/A          | 16GB  | 256GB NVME     | 1TB SATA HDD   | Proxmox VE 9.2             |