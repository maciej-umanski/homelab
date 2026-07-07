# Installation

## 1. Initial Setup

1. Find the NAS IP in DHCP leases on `rtr-core-01`, access `http://<IP>:8080`
2. Setup wizard:
    - NAS name: `nas-core-01`
    - Custom admin user (not `admin`)
    - Timezone: `Europe/Warsaw`, NTP: `time.cloudflare.com`
    - Network: DHCP
3. **Control Panel > Firmware Update** → install latest QTS 5.x, reboot

## 2. Storage

1. **Storage & Snapshots > Create > New Volume** → **Static Volume**
2. **VaultVol:** Disk 1
3. **MediaVol:** Disk 2

## 3. Shared Folders

1. **Control Panel > Privilege > Shared Folders** → delete defaults
2. Create `vault` on VaultVol — personal/family data, backed up via USB
3. Create `media` on MediaVol — media library, not backed up

## 4. Network Protocols

1. **NFS Service** → enable NFS v4
2. **Shared Folders > Edit Shared Folder Permission** → NFS host access for both folders:
    - `10.10.30.0/24`: `Read/Write`, `no_root_squash`

## 5. USB Backup (HBS 3)

1. Plug USB drive → **Storage & Snapshots > External Storage** → format as EXT4, label `USB_BACKUP`
2. App Center → install **HBS 3**
3. **HBS 3 > Backup & Restore > Create > Local Backup Job:**
    - Source: `vault` folder
    - Destination: `USB_BACKUP`
    - Schedule: daily at 03:00
    - Rules: `Delete extra files` (mirror)

## 6. macOS Integration

1. **Win/Mac/NFS/WebDAV > Service Discovery** → enable Bonjour for SAMBA
2. **Privilege > Users** → create accounts matching macOS logins
3. **Home Folder** button → enable for all users, disk volume: `VaultVol`