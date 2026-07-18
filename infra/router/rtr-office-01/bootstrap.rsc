# Create LAN bridge
/interface bridge add name=bridge

# Add all ethernet ports as LAN bridge ports
/interface bridge port
add bridge=bridge interface=ether1
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3

# LAN IP and DHCP so a client can reach the router for Terraform
/ip address add address=10.20.30.1/24 interface=bridge
/ip pool add ranges=10.20.30.100-10.20.30.200 name=lan-ip-pool
/ip dhcp-server add lease-time=1d address-pool=lan-ip-pool interface=bridge name=lan-dhcp-server disabled=no
/ip dhcp-server network add address=10.20.30.0/24 dns-server=10.20.30.1 gateway=10.20.30.1