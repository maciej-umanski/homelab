# Inventory

## Infrastructure

### Router

|   Hostname    | Manufacturer |  Model   | Operating System |
|:-------------:|:------------:|:--------:|:----------------:|
|  rtr-core-01  |   MikroTik   | hAP ax3  |    RouterOS 7    |
| rtr-office-01 |   MikroTik   | hAP mini |    RouterOS 7    |
| rtr-travel-01 |   MikroTik   | hAP mini |    RouterOS 7    |

### Switch

|  Hostname  | Manufacturer |  Model  | Operating System |
|:----------:|:------------:|:-------:|:----------------:|
| sw-core-01 |   MikroTik   | RB260GS |    SwOS 1.17     |

### Server

|   Hostname   |         Type          | Manufacturer |   Model   |       CPU        |      RAM      | System Storage |  Data Storage   |       Operating System        |
|:------------:|:---------------------:|:------------:|:---------:|:----------------:|:-------------:|:--------------:|:---------------:|:-----------------------------:|
| srv-core-01  |  Tiny USFF Computer   |    Lenovo    | M900 Tiny |  Intel I5-6500T  |  16 GB DDR4   |  256 GB NVME   | 480 GB SATA SSD |       Debian 13 Trixie        |
| srv-stage-01 |       Terminal        |      HP      |   T620    |   AMD GX-217GA   |   8 GB DDR3   |   16 GB SSD    | 240 GB USB SSD  |       Debian 13 Trixie        |
|  srv-rpi-01  | Single Board Computer | Raspberry Pi |  Zero W   | Broadcom BCM2835 | 512 MB LPDDR2 | 64 GB microSD  |       N/A       | Raspberry Pi OS Lite (32-bit) |

### Storage

|  hostname   | Type | Manufacturer |  Model  |            Storage             | Operating System |
|:-----------:|:----:|:------------:|:-------:|:------------------------------:|:----------------:|
| nas-core-01 | NAS  |     QNAP     | TS-231P | 2x 1TB 3.5" HDD + 1TB 2.5" HDD |      QTS 5       |

### Application

|     Application     |            Description            |
|:-------------------:|:---------------------------------:|
|       Arcane        |       Docker management UI        |
|        Gitea        |      Self-hosted Git service      |
|   Home Assistant    |     Home automation platform      |
|       Immich        | Photo/video backup and management |
|   iSponsorBlockTV   |  SponsorBlock integration for TV  |
|      Jellyfin       |           Media server            |
| Nginx Proxy Manager | Reverse proxy with SSL management |
|     Open WebUI      |        LLM chat interface         |
|   Shairport Sync    |      AirPlay audio receiver       |
