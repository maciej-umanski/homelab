# Installation

1. Connect computer with cable to `Ethernet 2` port
2. Login via Winbox using `admin` / sticker password
3. Execute:
   ```shell
   /system reset-configuration no-defaults=yes skip-backup=yes
   ```
4. Login again via Winbox using `admin` / blank password on MAC address
5. Change the `sysadmin` user password to a strong one in [bootstrap.rsc](bootstrap.rsc)
6. Change the `routeros.password` and `user.password` in [terraform.tfvars](terraform/terraform.tfvars) to match
7. Execute the bootstrap script via terminal
8. Run `terraform init && terraform apply` to apply the full configuration
