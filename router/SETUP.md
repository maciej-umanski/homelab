# Router configuration

## Bootstrap

1. Connect computer with cable to `Ethernet 5 port`
2. Login via winbox using `admin` / `default password`
3. Execute
    ```shell
    /system reset-configuration no-defaults=yes skip-backup=yes
    ```
4. Login again via winbox using `admin` / `blank password` on **ipv6 interface**
5. Update password with strong one
6. Execute [Bootstrap script](bootstrap/bootstrap.rsc) content using winbox terminal
7. Exit and login again on **ipv4 interface** to confirm bootstrap correctness

## Tofu

1. Create `terraform.tfvars` based on `variables.tofu`
2. Go to `router/tofu` directory
3. Invoke
   ```shell
   tofu init && tofu plan && tofu apply
   ```
