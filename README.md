# Netinfo.awk // 
A Linux Infra Network Interface Configuration Mapper

# Description
VipinkG/Vkg23/awk/LinuxNetinfoMapper  Version:5
A Configuration Summary Mapper for Linux Network Configurations. 
Represents the configuration from 
PCI-> Interface -> Bonding -> Mac -> PermMac -> Interface status -> Speed -> IP (IPv4/IPv6)

Tested: RHEL/CENTOS 6/7/8 

# Notes
V5 - includes check for "ip" binary locations. 
Tested for Physical Servers with RHEL 6/7/8 , CentOS
# How to Run  
Can Run as Normal / Root user locally in the system.
`awk -f Netinfo.awk 
     OR
./Netinfo.awk `
(optional argument '-4' for filtering only IPV4, else includes IPV6 by default)

# RoadMap:
#Cleanup , Error Checks/Debugs , Formatting for VM results, Remote Call options. 


# Sample Result
[Refer Code ]
https://github.com/vkg23/Netinfo.awk/blob/main/Netinfo.awk
