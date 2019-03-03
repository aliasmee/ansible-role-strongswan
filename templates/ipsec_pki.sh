#!/bin/bash
# 生成证书文件

ipsec pki --gen --outform pem > "{{cert_path}}"/ca.pem
ipsec pki --self --in "{{cert_path}}"/ca.pem --dn "{{ca_dn_info}}" --ca --lifetime "{{ca_lifetime}}" --outform pem >"{{cert_path}}"/ca.cert.pem

ipsec pki --gen --outform pem > "{{cert_path}}"/server.pem
ipsec pki --pub --in "{{cert_path}}"/server.pem | ipsec pki --issue --lifetime "{{server_lifetime}}" --cacert "{{cert_path}}"/ca.cert.pem --cakey "{{cert_path}}"/ca.pem --dn "{{server_dn_info}}, CN={{ vpn_liftid }}" --san="{{ vpn_liftid }}" --flag serverAuth --flag ikeIntermediate --outform pem > "{{cert_path}}"/server.cert.pem

ipsec pki --gen --outform pem > "{{cert_path}}"/client.pem
ipsec pki --pub --in "{{cert_path}}"/client.pem | ipsec pki --issue --cacert "{{cert_path}}"/ca.cert.pem --cakey "{{cert_path}}"/ca.pem --dn "{{client_dn_info}}" --outform pem > "{{cert_path}}"/client.cert.pem

# 拷贝文件到strongswan对应的目录

\cp "{{cert_path}}"/ca.cert.pem "{{install_dir}}"/strongswan-"{{strongswan_version}}"/etc/ipsec.d/cacerts/
\cp "{{cert_path}}"/server.cert.pem "{{install_dir}}"/strongswan-"{{strongswan_version}}"/etc/ipsec.d/certs/
\cp "{{cert_path}}"/server.pem "{{install_dir}}"/strongswan-"{{strongswan_version}}"/etc/ipsec.d/private/
\cp "{{cert_path}}"/server.pem "{{install_dir}}"/strongswan-"{{strongswan_version}}"/etc/ipsec.d/certs/
\cp "{{cert_path}}"/client.cert.pem "{{install_dir}}"/strongswan-"{{strongswan_version}}"/etc/ipsec.d/certs/
\cp "{{cert_path}}"/client.pem  "{{install_dir}}"/strongswan-"{{strongswan_version}}"/etc/ipsec.d/private/
