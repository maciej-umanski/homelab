# Installation

1. Connect computer with cable to `Ethernet 3 port`
2. Login via Winbox using `admin` / `default password`
3. Execute:
   ```shell
   /system reset-configuration no-defaults=yes skip-backup=yes
   ```
4. Login again via winbox using `admin` / `blank password` on **ipv6 interface or MAC**
5. Update password with strong one
6. Connect via ssh or via winbox terminal and execute [Bootstrap script](bootstrap.rsc)
