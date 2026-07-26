# Maintenance

Update and chore procedures for all homelab devices.

## Quick Reference

| Device        | Hostname      | Access                                          | Update Method           |
|:--------------|:--------------|:------------------------------------------------|:------------------------|
| Core Server   | srv-core-01   | `ssh sysadmin@srv-core-01.home.arpa`            | `apt` / Docker Compose  |
| Stage Server  | srv-stage-01  | `ssh sysadmin@srv-stage-01.home.arpa`           | `apt`                   |
| Pi Server     | srv-rpi-01    | `ssh sysadmin@srv-rpi-01.home.arpa`             | `apt`                   |
| Core Router   | rtr-core-01   | WinBox / `ssh sysadmin@rtr-core-01.home.arpa`   | RouterOS system package |
| Office Router | rtr-office-01 | WinBox / `ssh sysadmin@rtr-office-01.home.arpa` | RouterOS system package |
| Travel Router | rtr-travel-01 | WinBox / `ssh sysadmin@rtr-travel-01.home.arpa` | RouterOS system package |
| NAS           | nas-core-01   | `http://nas-core-01.home.arpa:8080/`            | QTS Firmware Update     |

---

## Data Location & Backup

|   Device    |        Location         | Method | Target                          | Schedule |
|:-----------:|:-----------------------:|--------|:--------------------------------|:---------|
| nas-core-01 |          vault          | HBS 3  | External HDD                    | Daily    |
| srv-core-01 | ssd/config + docker/opt | Rsync  | nas-core-01/vault/docker-backup | Weekly   |
| srv-core-01 |        ssd/media        | Manual | nas-core-01/media               | Monthly  |

---

## Periodic Chores

### Weekly

- Check HBS 3 backup status on nas-core-01: verify last backup completed without errors, confirm backup target is
  reachable
- Check docker backup status on srv-core-01: verify last backup completed without errors, confirm backup target is
  reachable
- Verify Docker applications are running: `docker ps --format "table {{.Names}}\t{{.Status}}"`
- Check Let's Encrypt certificate expiry in Nginx Proxy Manager UI (`http://srv-core-01.home.arpa:81`)

### Monthly

- Update RouterOS on all routers
- Update QTS firmware on nas-core-01
- Run system updates on all servers
- Pull updates and restart Docker applications
- Check for media that can be archived to nas-core-01/media and remove from srv-core-01/ssd/media

### Quarterly

- Update `terraform` and `ansible` applications on host machine (`brew upgrade terraform ansible`)
- Audit Terraform provider versions for available upgrades: `terraform init -upgrade`
- Check storage usage on all devices: `df -h` — alert if any filesystem exceeds 80%
- Review and prune adblock lists in DNS (rtr-core-01)
- Check for media that can be removed completely from `srv-core-01/ssd/media` and `nas-core-01/media`

---

## Servers

### Updating System Packages

Applicable to all servers: `srv-core-01`, `srv-stage-01`, `srv-rpi-01`.

```shell
ssh sysadmin@<hostname>.home.arpa
sudo apt update
sudo apt list --upgradable  # review what's changing
sudo apt upgrade --yes
sudo apt autoremove --purge --yes
sudo reboot
```

**Post-update verification:**

```shell
ssh sysadmin@<hostname>.home.arpa
uname -r                                            # confirm new kernel loaded
df -h                                               # no filesystem errors
docker ps --format "table {{.Names}}\t{{.Status}}"  # all containers up
```

### Updating Docker Applications

Applicable to `srv-core-01` server. Run for each application directory in `/opt/docker/<app>`.

```shell
ssh sysadmin@<hostname>.home.arpa
sudo -u dockersvc -i
cd /opt/docker/<app>
docker compose pull
docker compose up -d
docker compose ps             # confirm all services are up
docker compose logs --tail=30 # check for startup errors
```

**Post-update verification for all apps:**

```shell
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}"
docker system df  # check for stale images to prune
```

---

## Routers

### Updating RouterOS

Applicable to all routers: rtr-core-01, rtr-office-01, rtr-travel-01.

1. **Backup current configuration** before upgrading:
   ```
   /export file=pre-upgrade-backup
   ```
   Download the file via WinBox or SCP.

2. Check current version:
   ```
   /system resource print
   ```

3. Check for available upgrade:
   ```
   /system package update check-for-updates
   ```

4. Download and install:
   ```
   /system package update download
   /system reboot
   ```
   Or use WinBox: System > Software > Check For Updates > Download & Install.

---

## NAS

### Updating QTS

**nas-core-01** (QNAP TS-231P, QTS 5).

1. Access the web interface at `http://nas-core-01.home.arpa:8080/`
2. **Backup NAS configuration** before upgrading: - Control Panel > System > Backup & Restore > Backup System Settings
3. Control Panel > System > Firmware Update
4. Check for updates and install
5. Reboot if required
6. **Post-update verification:**
    - Verify all shares are accessible: `smb://nas-core-01.home.arpa`
    - Check HBS 3 backup jobs are still configured and enabled
    - Confirm storage pool and volume health in Storage & Snapshots
    - Run a manual SMART test on all drives

---

## Security

### Let's Encrypt Certificate Renewal

Nginx Proxy Manager auto-renews certificates 30 days before expiry. Verify by:

1. Open NPM admin: `http://srv-core-01.home.arpa:81`
2. SSL Certificates tab — check no certificates are near expiry (30-day renewal window)
3. If auto-renewal has failed, verify firewall rule allow ing inbound HTTP traffic to NPM, and check DNS resolution for
   the domain.
4. trigger manual renewal and check DNS propagation

---

## Repository

### Upgrading Docker Image Versions

Docker applications are defined in `app/<name>/docker-compose.yml`. Images are pinned to specific versions (not
`:latest`) for reproducible deploys.

1. Check current pinned version in `docker-compose.yml`
2. Review upstream release notes for breaking changes
3. Update the image tag in `docker-compose.yml`
4. Deploy the update using the procedure in [Updating Docker Applications](#updating-docker-applications)
5. Verify the app is functional (log in, check core features)
6. Commit and push the updated tag

### Upgrading Terraform Providers

Provider versions are pinned in each `infra/router/<routername>/terraform/versions.tf` file. Check for available
upgrades and update the version.

```shell
cd infra/router/<routername>/terraform
terraform init -upgrade
terraform plan
```

If the provider introduced breaking schema changes, update resource definitions accordingly before committing.
