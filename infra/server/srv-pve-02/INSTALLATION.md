# Installation

1. Boot [Proxmox VE](https://www.proxmox.com/en/downloads/proxmox-virtual-environment) installer in **Graphical, Debug**
   mode
2. Skip first shell. Type exit or press Ctrl+D.
3. On second shell, execute `vi /usr/share/perl5/Proxmox/Sys/Block.pm`
4. Modify `get_partition_dev` function to support MMC devices:
   ```
   sub get_partition_dev {
       my ($dev, $partnum) = @_;
   
       if ($dev =~ m|^/dev/sd([a-h]?[a-z]|i[a-v])$|) {
           return "${dev}$partnum";
       } elsif ($dev =~ m|^/dev/mmcblk\d+$|) {  ## Line Added
           return "${dev}p$partnum";            ## Line Added
   ```
5. Back at the shell prompt, type exit or press Ctrl+D one last time.
6. During installation configure:
   - Disk: `zfs (RAID 0)` using only Harddisk 0
   - Network: Enable pinning interfaces
   - Hostname: `srv-pve-02.home.arpa`
   - Keymap: `pl`
   - Timezone: `Europe/Warsaw`