# Inventory

## Infrastructure

### Router

|   Hostname    |  Type  | Manufacturer |  Model   | Operating System |                     Description                     |
|:-------------:|:------:|:------------:|:--------:|:----------------:|:---------------------------------------------------:|
|  rtr-core-01  | Router |   MikroTik   | hAP ax3  |    RouterOS 7    |            Main router for home network             |
|  rtr-lab-01   | Router |   MikroTik   | hAP mini |    RouterOS 7    |         Auxiliary router for QA and testing         |
| rtr-travel-01 | Router |   MikroTik   | hAP mini |    RouterOS 7    | Travel router for remote access and VPN connections |

### Switch

| Hostname  |  Type  | Manufacturer |  Model  | Operating System |    Description     |
|:---------:|:------:|:------------:|:-------:|:----------------:|:------------------:|
| sw-srv-01 | Switch |   MikroTik   | RB260GS |    SwOS 1.17     | Switch for servers |

### Server

|    Hostname    |         Type          | Manufacturer |      Model      |         CPU         |       GPU       |  RAM   | System Storage |     Data Storage     |      Operating System      | Description                                                           |
|:--------------:|:---------------------:|:------------:|:---------------:|:-------------------:|:---------------:|:------:|:--------------:|:--------------------:|:--------------------------:|:----------------------------------------------------------------------|
|  srv-core-01   |       Terminal        |      HP      |      T620       |    AMD GX-217GA     |       N/A       |  8 GB  |   16 GB SSD    | 480 GB USB3 2.5" SSD |         Debian 13          | Core server for 24/7 home network and services                        |
| srv-compute-01 |        Laptop         |    Lenovo    |    Legion 5     |  AMD Ryzen 5 5600H  | RTX 3050 Mobile | 16 GB  |  240 GB NVME   |     480 GB NVME      |  Ubuntu Server 26.04 LTS   | Compute intensive server for AI/ML and other workloads                |
|   srv-pve-01   |  Tiny USFF Computer   |    Lenovo    |    M900 Tiny    |   Intel I5-6500T    |       N/A       | 16 GB  |  256 GB NVME   |  1 TB SATA 2.5" HDD  |        Proxmox VE 9        | Core node virtualization server for hosting VMs and containers        |
|   srv-pve-02   |        Laptop         |     Dell     | Chromebook 3100 | Intel Celeron N4000 |       N/A       |  4 GB  |   32 GB eMMC   |         N/A          |        Proxmox VE 9        | Additionall node virtualization server for hosting VMs and containers |
|   srv-rpi-01   | Single Board Computer | Raspberry Pi |     Zero W      |  Broadcom BCM2835   |       N/A       | 512 MB | 64 GB microSD  |         N/A          | Raspberry Pi OS Lite 32bit | tba                                                                   |

### Storage

|  hostname   | Type | Manufacturer |  Model  | Capacity | Operating System |
|:-----------:|:----:|:------------:|:-------:|:--------:|:----------------:|
| nas-core-01 | NAS  |     QNAP     | TS-231P |  2x 1TB  |      QTS 5       |

## Applications

## Docker

|       Service       |    Host     |                        Description                         |
|:-------------------:|:-----------:|:----------------------------------------------------------:|
|   **uptime-kuma**   | srv-core-01 |       Monitoring tool for services and applications        |
| **shairport-sync**  | srv-core-01 |   AirPlay audio receiver for streaming music to speakers   |
| **home-assistant**  | srv-core-01 |   Home automation platform for controlling smart devices   |
|    **jellyfin**     | srv-core-01 |   Media server for streaming movies, TV shows, and music   |
| **isponsorblocktv** | srv-core-01 | Automatic skipping of sponsored segments in YouTube videos |
