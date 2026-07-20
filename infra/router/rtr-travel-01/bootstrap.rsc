# Create sysadmin user
/user add name=sysadmin group=full password="{change_me}"

# Create LAN bridge
/interface bridge add name=bridge

# IP and DHCP configuration
/ip address add address=10.30.20.1/24 interface=bridge network=10.30.20.0
/ip pool add name=lan-ip-pool ranges=10.30.20.100-10.30.20.250
/ip dhcp-server add address-pool=lan-ip-pool interface=bridge name=lan-dhcp-server disabled=no add-arp=yes lease-time=1d
/ip dhcp-server network add address=10.30.20.0/24 dns-server=10.30.20.1 gateway=10.30.20.1

# Configure local CA and sign the root certificate
/certificate/add name=local-root-cert common-name=local-cert key-size=prime256v1 key-usage=key-cert-sign,crl-sign trusted=yes
/certificate/sign local-root-cert
/certificate/set local-root-cert trusted=yes
/certificate/add name=webfig common-name=10.30.20.1 country=PL locality=WAW organization=MACIEJ-UMANSKI unit=HOME days-valid=3650 key-size=prime256v1 key-usage=key-cert-sign,crl-sign,digital-signature,key-agreement,tls-server trusted=yes
/certificate/sign ca=local-root-cert webfig
/certificate/set webfig trusted=yes
/ip/service/set www-ssl certificate=webfig disabled=no
/ip/service/enable www-ssl

# Add LAN ports to the bridge
/interface bridge port
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3
