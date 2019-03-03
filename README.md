# Ansible Role: strongSwan
Let's quickly deploy a popular vpn service using ansible and authenticate with ldap, on CentOS or Ubuntu servers.😎

## Requirements

* Root privileges;
* If you want to enable ldap authentication, have radius and ldap services ready
  - aliasmee.freeradius
  - aliasmee.ldap [WIP]

## Role Variables

The following variables are currently supported,The default value is in defaults/main.yml.

variables_name | Description | Default
--- | --- | ---
`strongswan_version` | strongSwan Version | `5.7.2`
`vpn_liftid` | vpn server address and remote ID | `ipify_public_ip`
`dn_prefix` | ca cert info prefix | `C=cn, O=example`
`ca_dn_info` | ca cert info | `"{{dn_prefix}}, CN=VPN CA"`
`server_dn_info` | server cert info | `"{{dn_prefix}}"`
`client_dn_info` | client dn info | `"{{dn_prefix}}, CN=VPN Client"`
`ca_lifetime` | ca cert validity period (Unit: Day) | `3650`
`server_lifetime` | server cert validity period (Unit: Day) | `1200`
`client_dhcp_ip` | client connect vpn after allocated virtual ip | `10.28.0.0/24`
`client_dhcp_dns` | client connect vpn agter allocated dns server | `8.8.8.8`
`client_auth` | client auth method, [eap-mschapv2, eap-radius] | `eap-mschapv2`
`client_tunnel_range` | Only these flows accors this tunnel-> tunnel-slpit | `0.0.0.0/0`
`enabled_radius` | If you want to use ldap authentication, please set to yes. | `no`
`radius_port` | radius server port | `1812`
`radius_secret` | radius server connect secret | `testing123`
`radius_ip` | radius server address | `127.0.0.1`
`view_certificate` | whether to view ca certificate content | `False`

## Dependencies
If you want to use ldap authentication, Please refer to the following instructions to access ldap.
