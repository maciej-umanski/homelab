# Create sysadmin user
/user add name=sysadmin group=full password="{change_me}"

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

# Configure local CA and sign the root certificate
/certificate/add name=local-root-cert common-name=local-cert key-size=prime256v1 key-usage=key-cert-sign,crl-sign trusted=yes
/certificate/sign local-root-cert
/certificate/add name=webfig common-name=10.10.99.1 country=PL locality=WAW organization=MACIEJ-UMANSKI unit=HOME days-valid=3650 key-size=prime256v1 key-usage=key-cert-sign,crl-sign,digital-signature,key-agreement,tls-server trusted=yes
/certificate/sign ca=local-root-cert webfig
/ip/service/set www-ssl certificate=webfig disabled=no
/ip/service/enable www-ssl
