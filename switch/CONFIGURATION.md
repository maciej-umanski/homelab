# Configuration

## 1. Link

| Setting          | Port1           | Port2   | Port3   | Port4   | Port5   |
|------------------|-----------------|---------|---------|---------|---------|
| Enabled          | `[✓]`           | `[✓]`   | `[✓]`   | `[✓]`   | `[✓]`   |
| Name             | `Uplink Router` | `Port2` | `Port3` | `Port4` | `Port5` |
| Auto Negotiation | `[✓]`           | `[✓]`   | `[✓]`   | `[✓]`   | `[✓]`   |
| Flow Control     | `[✓]`           | `[✓]`   | `[✓]`   | `[✓]`   | `[✓]`   |

## 2. SFP

| Setting          | Value |
|------------------|-------|
| Enabled          | `[✓]` |
| Name             | `SFP` |
| Auto Negotiation | `[✓]` |

## 3. Forwarding

### Forwarding

| Setting    | Port1 | Port2 | Port3 | Port4 | Port5 | SFP   |
|------------|-------|-------|-------|-------|-------|-------|
| From Port1 | `[✗]` | `[✓]` | `[✓]` | `[✓]` | `[✓]` | `[✓]` |
| From Port2 | `[✓]` | `[✗]` | `[✓]` | `[✓]` | `[✓]` | `[✓]` |
| From Port3 | `[✓]` | `[✓]` | `[✗]` | `[✓]` | `[✓]` | `[✓]` |
| From Port4 | `[✓]` | `[✓]` | `[✓]` | `[✗]` | `[✓]` | `[✓]` |
| From Port5 | `[✓]` | `[✓]` | `[✓]` | `[✓]` | `[✗]` | `[✓]` |
| From SFP   | `[✓]` | `[✓]` | `[✓]` | `[✓]` | `[✓]` | `[✗]` |

### Port Lock

| Setting       | Port1 | Port2 | Port3 | Port4 | Port5 |
|---------------|-------|-------|-------|-------|-------|
| Port Lock     | `[✓]` | `[✓]` | `[✓]` | `[✓]` | `[✓]` |
| Lock On First | `[✓]` | `[✓]` | `[✓]` | `[✓]` | `[✓]` |

### Port Mirroring

| Setting        | Port1 | Port2 | Port3 | Port4 | Port5 |
|----------------|-------|-------|-------|-------|-------|
| Mirror Ingress | `[✗]` | `[✗]` | `[✗]` | `[✗]` | `[✗]` |
| Mirror Egress  | `[✗]` | `[✗]` | `[✗]` | `[✗]` | `[✗]` |
| Mirror To      | `[✓]` | `[✗]` | `[✗]` | `[✗]` | `[✗]` |

### Bandwidth Limit

| Setting     | Port1     | Port2     | Port3     | Port4     | Port5     |
|-------------|-----------|-----------|-----------|-----------|-----------|
| Egress Rate | `       ` | `       ` | `       ` | `       ` | `       ` |

## 4. VLAN

### Ingress

| Setting         | Port1     | Port2           | Port3           | Port4           | Port5      | SFP        |
|-----------------|-----------|-----------------|-----------------|-----------------|------------|------------|
| VLAN Mode       | `enabled` | `strict`        | `strict`        | `strict`        | `optional` | `optional` |
| VLAN Receive    | `any`     | `only untagged` | `only untagged` | `only untagged` | `any`      | `any`      |
| Default VLAN ID | `1`       | `10`            | `10`            | `10`            | `1`        | `1`        |
| Force VLAN ID   | `[✗]`     | `[✗]`           | `[✗]`           | `[✗]`           | `[✗]`      | `[✗]`      |

### Egress

| Setting     | Port1         | Port2          | Port3          | Port4          | Port5         | SFP           |
|-------------|---------------|----------------|----------------|----------------|---------------|---------------|
| VLAN Header | `leave as is` | `always strip` | `always strip` | `always strip` | `leave as is` | `leave as is` |

## 5. VLANs

| VLAN ID | IVL   | Port1         | Port2          | Port3          | Port4          | Port5         | SFP           |
|---------|-------|:--------------|----------------|----------------|----------------|---------------|---------------|
| `1`     | `[✗]` | `leave as is` | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is` | `leave as is` |
| `10`    | `[✗]` | `leave as is` | `always strip` | `always strip` | `always strip` | `leave as is` | `leave as is` |
| `99`    | `[✗]` | `leave as is` | `leave as is`  | `leave as is`  | `leave as is`  | `leave as is` | `leave as is` |

## 6. Static Hosts

| Port1 | Port2 | Port3 | Port4 | Port5 | SFP | MAC | VLAN ID | Drop | Mirror |
|-------|-------|-------|-------|-------|-----|-----|---------|------|--------|

## 7. SNMP

| Setting      | Value      |
|--------------|------------|
| Enabled      | `[✓]`      |
| Community    | `public`   |
| Contact Info | `        ` |
| Location     | `        ` |

## 8. ACL

| From | MAC Src | MAC Dst | Ethertype | VLAN | VLAN ID | Priority | IP Src | IP Dst | Protocol | DSCP | Redirect To | Mirror | Rate | Set VLAN ID | Priority |
|------|---------|---------|-----------|------|---------|----------|--------|--------|----------|------|-------------|--------|------|-------------|----------|

## 9. System

| Setting                     | Value                                         |
|-----------------------------|-----------------------------------------------|
| IP Address                  | `10.10.99.2`                                  |
| Identity                    | `switch`                                      |
| Allow From                  | `                                           ` |
| Allow From Ports            | `[✓]`1 `[✓]`2 `[✓]`3 `[✓]`4 `[✓]`5 `[✓]`SFP   |
| Allow From VLAN             | `                                           ` |
| Watchdog                    | `[✓]`                                         |
| Mikrotik Discovery Protocol | `[✓]`                                         |
