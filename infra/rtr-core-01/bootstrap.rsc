# Create bridge with VLAN filtering
/interface bridge add name=bridge vlan-filtering=yes

# Add VLAN 99 on the bridge interface
/interface vlan add interface=bridge vlan-id=99 name=vlan99-management

# Add ether5 as bridge port with PVID 99 (untagged access port)
/interface bridge port add bridge=bridge interface=ether5 pvid=99 frame-types=admit-only-untagged-and-priority-tagged

# IP and DHCP configuration
/ip address add address=10.10.99.1/24 interface=vlan99-management
/ip pool add ranges=10.10.99.100-10.10.99.199 name=vlan99-management-ip-pool
/ip dhcp-server add lease-time=1d address-pool=vlan99-management-ip-pool interface=vlan99-management name=vlan99-management-dhcp-server disabled=no
/ip dhcp-server network add address=10.10.99.0/24 dns-server=10.10.99.1 gateway=10.10.99.1

# Bridge VLAN config
/interface bridge vlan add bridge=bridge vlan-ids=99 tagged=bridge untagged=ether5