# Installation

## Connection

1. Connect computer with cable to `Ethernet 1 port`
2. Set static IP address on computer to
    ```
       IP: 192.168.88.10
       Mask: 255.255.255.0
    ```
3. Access `http://192.168.88.1` and login using `admin` / `blank password`
4. Update password with strong one

## Configuration

### 1. Link

|     Setting      |     Port1     |     Port2      |   Port3   |   Port4   |    Port5     |
|:----------------:|:-------------:|:--------------:|:---------:|:---------:|:------------:|
|     Enabled      |     `[✓]`     |     `[✓]`      |   `[✓]`   |   `[✓]`   |    `[✓]`     |
|       Name       | `rtr-core-01` | `srv-stage-01` | `gaming1` | `gaming2` | `srv-rpi-01` |
| Auto Negotiation |     `[✓]`     |     `[✓]`      |   `[✓]`   |   `[✓]`   |    `[✓]`     |
|   Flow Control   |     `[✓]`     |     `[✓]`      |   `[✓]`   |   `[✓]`   |    `[✓]`     |

### 2. SFP

|     Setting      | Value |
|:----------------:|:-----:|
|     Enabled      | `[ ]` |
|       Name       | `SFP` |    
| Auto Negotiation | `[✓]` |

### 3. Forwarding

#### Forwarding

|      Setting      | rtr-core-01 | srv-stage-01 | gaming1 | gaming2 | srv-rpi-01 |  SFP  |
|:-----------------:|:-----------:|:------------:|:-------:|:-------:|:----------:|:-----:|
| From rtr-core-01  |    `[ ]`    |    `[✓]`     |  `[✓]`  |  `[✓]`  |   `[✓]`    | `[✓]` |
| From srv-stage-01 |    `[✓]`    |    `[ ]`     |  `[✓]`  |  `[✓]`  |   `[✓]`    | `[✓]` |
|   From gaming1    |    `[✓]`    |    `[✓]`     |  `[ ]`  |  `[✓]`  |   `[✓]`    | `[✓]` |
|   From gaming2    |    `[✓]`    |    `[✓]`     |  `[✓]`  |  `[ ]`  |   `[✓]`    | `[✓]` |
|  From srv-rpi-01  |    `[✓]`    |    `[✓]`     |  `[✓]`  |  `[✓]`  |   `[ ]`    | `[✓]` |
|     From SFP      |    `[✓]`    |    `[✓]`     |  `[✓]`  |  `[✓]`  |   `[✓]`    | `[ ]` |

#### Port Lock

|    Setting    | rtr-core-01 | srv-stage-01 | gaming1 | gaming2 | srv-rpi-01 |  SFP  |
|:-------------:|:-----------:|:------------:|:-------:|:-------:|:----------:|:-----:|
|   Port Lock   |    `[✓]`    |    `[✓]`     |  `[✓]`  |  `[✓]`  |   `[✓]`    | `[✓]` |
| Lock On First |    `[✓]`    |    `[✓]`     |  `[✓]`  |  `[✓]`  |   `[✓]`    | `[✓]` |

#### Port Mirroring

|    Setting     | rtr-core-01 | srv-stage-01 | gaming1 | gaming2 | srv-rpi-01 |  SFP  |
|:--------------:|:-----------:|:------------:|:-------:|:-------:|:----------:|:-----:|
| Mirror Ingress |    `[ ]`    |    `[ ]`     |  `[ ]`  |  `[ ]`  |   `[ ]`    | `[ ]` |
| Mirror Egress  |    `[ ]`    |    `[ ]`     |  `[ ]`  |  `[ ]`  |   `[ ]`    | `[ ]` |
|   Mirror To    |    `(✓)`    |    `( )`     |  `( )`  |  `( )`  |   `( )`    | `( )` |

#### Bandwidth Limit

|   Setting   | rtr-core-01 | srv-stage-01 |  gaming1  |  gaming2  | srv-rpi-01 |    SFP    |
|:-----------:|:-----------:|:------------:|:---------:|:---------:|:----------:|:---------:|
| Egress Rate |  `       `  |  `       `   | `       ` | `       ` | `       `  | `       ` |

### 4. VLAN

#### Ingress

|     Setting     | rtr-core-01 |  srv-stage-01   |     gaming1     |     gaming2     |   srv-rpi-01    |    SFP    |
|:---------------:|:-----------:|:---------------:|:---------------:|:---------------:|:---------------:|:---------:|
|    VLAN Mode    |  `enabled`  |    `strict`     |    `strict`     |    `strict`     |    `strict`     | `enabled` |
|  VLAN Receive   |    `any`    | `only untagged` | `only untagged` | `only untagged` | `only untagged` |   `any`   |
| Default VLAN ID |     `1`     |      `30`       |      `60`       |      `60`       |      `30`       |    `1`    |
|  Force VLAN ID  |    `[ ]`    |      `[ ]`      |      `[ ]`      |      `[ ]`      |      `[ ]`      |   `[ ]`   |

#### Egress

|   Setting   |  rtr-core-01  |  srv-stage-01  |    gaming1     |    gaming2     |   srv-rpi-01   |      SFP      |
|:-----------:|:-------------:|:--------------:|:--------------:|:--------------:|:--------------:|:-------------:|
| VLAN Header | `leave as is` | `always strip` | `always strip` | `always strip` | `always strip` | `leave as is` |

### 5. VLANs

| VLAN ID |  IVL  |  rtr-core-01  |  srv-stage-01  |    gaming1     |    gaming2     |   srv-rpi-01   |      SFP      |
|:-------:|:-----:|:-------------:|:--------------:|:--------------:|:--------------:|:--------------:|:-------------:|
|  `30`   | `[ ]` | `leave as is` | `always strip` | `leave as is`  | `leave as is`  | `always strip` | `leave as is` |
|  `60`   | `[ ]` | `leave as is` | `leave as is`  | `always strip` | `always strip` | `leave as is`  | `leave as is` |
|  `99`   | `[ ]` | `leave as is` | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is` |

### 6. Static Hosts

| rtr-core-01 | srv-stage-01 | gaming1 | gaming2 | srv-rpi-01 | SFP | MAC | VLAN ID | Drop | Mirror |
|:-----------:|:------------:|:-------:|:-------:|:----------:|:---:|:---:|:-------:|:----:|:------:|

### 7. SNMP

|   Setting    |   Value    |
|:------------:|:----------:|
|   Enabled    |   `[✓]`    |
|  Community   |  `public`  |
| Contact Info | `        ` |
|   Location   | `        ` |

### 8. ACL

| From | MAC Src | MAC Dst | Ethertype | VLAN | VLAN ID | Priority | IP Src | IP Dst | Protocol | DSCP | Redirect To | Mirror | Rate | Set VLAN ID | Priority |
|:----:|:-------:|:-------:|:---------:|:----:|:-------:|:--------:|:------:|:------:|:--------:|:----:|:-----------:|:------:|:----:|:-----------:|:--------:|

### 9. System

|           Setting           |                     Value                     |
|:---------------------------:|:---------------------------------------------:|
|         IP Address          |                 `10.10.99.2`                  |
|          Identity           |                 `sw-core-01`                  |
|         Allow From          | `                                           ` |
|      Allow From Ports       |  `[✓]`1 `[ ]`2 `[ ]`3 `[ ]`4 `[ ]`5 `[ ]`SFP  |
|       Allow From VLAN       | `                                           ` |
|          Watchdog           |                     `[✓]`                     |
| Mikrotik Discovery Protocol |                     `[✓]`                     |