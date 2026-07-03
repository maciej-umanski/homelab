# Installation

1. Install [Proxmox VE](https://www.proxmox.com/en/downloads/proxmox-virtual-environment) with `zfs (RAID 0)`
2. During installation configure:
   - Disk: `zfs (RAID 0)` using only Harddisk 0
   - Network: Enable pinning interfaces
   - Hostname: `srv-pve-01.home.arpa`
   - Keymap: `pl`
    - Timezone: `Europe/Warsaw`
