# Configuration

## 1. Link

|     Setting      |  Port1   | Port2 |     Port3     | Port4  |  Port5   |
|:----------------:|:--------:|:-----:|:-------------:|:------:|:--------:|
|     Enabled      |  `[✓]`   | `[✓]` |     `[✓]`     | `[✓]`  |  `[✓]`   |
|       Name       | `router` | `hp`  | `thinkcentre` | `dell` | `legion` |
| Auto Negotiation |  `[✓]`   | `[✓]` |     `[✓]`     | `[✓]`  |  `[✓]`   |
|   Flow Control   |  `[✓]`   | `[✓]` |     `[✓]`     | `[✓]`  |  `[✓]`   |

## 2. SFP

|     Setting      | Value |
|:----------------:|:-----:|
|     Enabled      | `[✓]` |
|       Name       | `rpi` |    
| Auto Negotiation | `[✓]` |

## 3. Forwarding

### Forwarding

|     Setting      | router |  hp   | thinkcentre | dell  | legion |  rpi  |
|:----------------:|:------:|:-----:|:-----------:|:-----:|:------:|:-----:|
|   From router    | `[ ]`  | `[✓]` |    `[✓]`    | `[✓]` | `[✓]`  | `[✓]` |
|     From hp      | `[✓]`  | `[ ]` |    `[✓]`    | `[✓]` | `[✓]`  | `[✓]` |
| From thinkcentre | `[✓]`  | `[✓]` |    `[ ]`    | `[✓]` | `[✓]`  | `[✓]` |
|    From dell     | `[✓]`  | `[✓]` |    `[✓]`    | `[ ]` | `[✓]`  | `[✓]` |
|   From legion    | `[✓]`  | `[✓]` |    `[✓]`    | `[✓]` | `[ ]`  | `[✓]` |
|     From rpi     | `[✓]`  | `[✓]` |    `[✓]`    | `[✓]` | `[✓]`  | `[ ]` |

### Port Lock

|    Setting    | router |  hp   | thinkcentre | dell  | legion |  rpi  |
|:-------------:|:------:|:-----:|:-----------:|:-----:|:------:|:-----:|
|   Port Lock   | `[✓]`  | `[✓]` |    `[✓]`    | `[✓]` | `[✓]`  | `[✓]` |
| Lock On First | `[✓]`  | `[✓]` |    `[✓]`    | `[✓]` | `[✓]`  | `[✓]` |

### Port Mirroring

|    Setting     | router |  hp   | thinkcentre | dell  | legion |  rpi  |
|:--------------:|:------:|:-----:|:-----------:|:-----:|:------:|:-----:|
| Mirror Ingress | `[ ]`  | `[ ]` |    `[ ]`    | `[ ]` | `[ ]`  | `[ ]` |
| Mirror Egress  | `[ ]`  | `[ ]` |    `[ ]`    | `[ ]` | `[ ]`  | `[ ]` |
|   Mirror To    | `(✓)`  | `( )` |    `( )`    | `( )` | `( )`  | `( )` |

### Bandwidth Limit

|   Setting   |  router   |    hp     | thinkcentre |   dell    |  legion   |    rpi    |
|:-----------:|:---------:|:---------:|:-----------:|:---------:|:---------:|:---------:|
| Egress Rate | `       ` | `       ` |  `       `  | `       ` | `       ` | `       ` |

## 4. VLAN

### Ingress

|     Setting     |  router   |       hp        |   thinkcentre   |      dell       |     legion      |       rpi       |
|:---------------:|:---------:|:---------------:|:---------------:|:---------------:|:---------------:|:---------------:|
|    VLAN Mode    | `enabled` |    `strict`     |    `strict`     |    `strict`     |    `strict`     |    `strict`     |
|  VLAN Receive   |   `any`   | `only untagged` | `only untagged` | `only untagged` | `only untagged` | `only untagged` |
| Default VLAN ID |    `1`    |      `30`       |      `30`       |      `30`       |      `30`       |      `30`       |
|  Force VLAN ID  |   `[ ]`   |      `[ ]`      |      `[ ]`      |      `[ ]`      |      `[ ]`      |      `[ ]`      |

### Egress

|   Setting   |    router     |       hp       |  thinkcentre   |      dell      |     legion     |      rpi       |
|:-----------:|:-------------:|:--------------:|:--------------:|:--------------:|:--------------:|:--------------:|
| VLAN Header | `leave as is` | `always strip` | `always strip` | `always strip` | `always strip` | `always strip` |

## 5. VLANs

| VLAN ID |  IVL  |    router     |       hp       |  thinkcentre   |      dell      |     legion     |      rpi       |
|:-------:|:-----:|:-------------:|:--------------:|:--------------:|:--------------:|:--------------:|:--------------:|
|   `1`   | `[ ]` | `leave as is` | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is`  |
|  `30`   | `[ ]` | `leave as is` | `always strip` | `always strip` | `always strip` | `always strip` | `always strip` |
|  `99`   | `[ ]` | `leave as is` | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is`  |

## 6. Static Hosts

| router | hp | thinkcentre | dell | legion | rpi | MAC | VLAN ID | Drop | Mirror |
|:------:|:--:|:-----------:|:----:|:------:|:---:|:---:|:-------:|:----:|:------:|

## 7. SNMP

|   Setting    |   Value    |
|:------------:|:----------:|
|   Enabled    |   `[✓]`    |
|  Community   |  `public`  |
| Contact Info | `        ` |
|   Location   | `        ` |

## 8. ACL

| From | MAC Src | MAC Dst | Ethertype | VLAN | VLAN ID | Priority | IP Src | IP Dst | Protocol | DSCP | Redirect To | Mirror | Rate | Set VLAN ID | Priority |
|:----:|:-------:|:-------:|:---------:|:----:|:-------:|:--------:|:------:|:------:|:--------:|:----:|:-----------:|:------:|:----:|:-----------:|:--------:|

## 9. System

|           Setting           |                     Value                     |
|:---------------------------:|:---------------------------------------------:|
|         IP Address          |                 `10.10.99.2`                  |
|          Identity           |                   `switch`                    |
|         Allow From          | `                                           ` |
|      Allow From Ports       |  `[✓]`1 `[ ]`2 `[ ]`3 `[ ]`4 `[ ]`5 `[ ]`SFP  |
|       Allow From VLAN       | `                                           ` |
|          Watchdog           |                     `[✓]`                     |
| Mikrotik Discovery Protocol |                     `[✓]`                     |
