#!/usr/bin/env bash

sudo su -

# Create some aliases
cat <<EOF >> ~/.bashrc
alias master_status='systemctl status openshift-master'
alias master_stop='systemctl stop openshift-master'
alias master_start='systemctl start openshift-master'
alias master_restart='systemctl restart openshift-master'
EOF

## Note: No ssh key is generated here. Existing keys are copied.
## This would generated a key: "ssh-keygen -f /root/.ssh/id_rsa -N ''" 

cat <<EOF >> ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmmlUTyUVTtm8enVxfR8sJvXAhEMJ4wg1TN3owefelcfNjd+327j1jJ4NbjzSGRwfV2i/TLKkA747+SXnebeJbQ5L8p1Fi9SHMuRm6H/1q5J6Y1mhjm0G+fVKOGy0gM5ax8NQfUQHTX08tv8Khfdzm7p9Fq/qMG/EANmm9Zh2+ExUVDakCDLl5IppHoxieiiE61f+159V9enjnKoaagBgRW+/tITwj6irbXcM545+j0x05kfAeLbmyDh2zLpaPRSAouvx58UE+toZANykGNS4PE1IbMmDPylfAC7e9evVtwH58g/rM5K1G4mvpGPajAEiBLtBPwxRYa/iwiQdumvoT root@master.giraffe-cloud.com
EOF

cat <<EOF >> /root/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA5ppVE8lFU7ZvHp1cX0fLCb1wIRDCeMINUzd6MHn3pXHzY3ft
9u49YyeDW480hkcH1dov0yypAO+O/kl53m3iW0OS/KdRYvUhzLkZuh/9auSemNZo
Y5tBvn1SjhstIDOWsfDUH1EB019PLb/CoX3c5u6fRav6jBvxADZpvWYdvhMVFQ2p
Agy5eSKaR6MYnoohOtX/tefVfXp45yqGmoAYEVvv7SE8I+oq213DOeOfo9MdOZHw
Hi25sg4dsy6Wj0UgKLr8efFBPraGQDcpBjUuDxNSGzJgz8pXwAu3vXr1bcB+fIP6
zOStRuJr6Rj2owBIgS7QT8MUWGv4sIkHbpr6EwIDAQABAoIBABrz9vW1FLFQJXTC
l8VbMtQUnEKBHvnWVJBhb5qy5ssjonsBzYKLHgm02JmfB1iafMP2GJjqI2bEmUYH
eIMS/N4F6+wz8kNKu4SeLe+fRZN03USn6tOZlfmZ1EhfzMpyvS5XI7P1V+1Iuoxy
WWFewK8NPPh7vXEa4vRPZ9SHVvqcL4kGT1XslbxrxTQHcj/sa3R5EwCoq30rujLT
NI8NXSb9i0FJ1gv8ACVvN1r9vdJSI+eUWZIFp9TZh+7q7cPC+9XOOBwdaPIvCpbI
9MROxdyC6Mf6z8cEFkYEhnBMd/P8MoPHid4MfQjswgCxhyrr86k54VM1W0k1Aihx
6mNqCsECgYEA+9uOA2YQRkxQSFsBYJ9PFvrCY/yH+J/SjcHosYeueKzgyBCMr2Or
FMFOMAAXVI1BWCGVtwLpcxsDnCa9DdFBQ6E9Nl9pEvEweepy/C/miijr9/MVrwMc
yHVTURSyQPwl9aLI3AhD0BgabsKzYD4a7rInUEEISPH6xWPt4KQmFVsCgYEA6mVI
01IQHMiCl3IGK8lEjVyqr5WxRRNsDOGze251xtES8VvO/aalFLePFLB4cqfh54aq
POdslem+jH7YlGqSpY9PUoZcsu2sqANM0AUcb+u+GgbWyYijfZNZeM/9O7bYeq5Z
eklt1AuQJVbwWn1jl+5kl0gfgcooofBdB1TNc6kCgYEAkWwfXsUC5qRPwseRTwoN
b7ZQoc0BccROnf1173PpgNJJZBtyMB87fFt1Wu/iiLabIVkbCjYLN6REfFg91wmZ
RoSGRKvojsBm/i4qQIUj92hTf7KDNa91YiWkeu+ZUT6GaIOauLmo9jHEqWmQiySx
BlwlqQgz0XKvGmRtyMTfHHsCgYEApCcEpoH9KLs/weIn8jhFGx7/pnIWMMMWU7sp
IFNOhktbkc5zGu6/A9A9kwa3g8yRB70msfp88Ew/l1MqSF6OjwXbTncsql6LISsW
e0RpEvStMLsDZyabING1wkcfGNfHqbs6jMqp8OucKppFP4o62mco6U2oSxQR+r9D
12OLcukCgYEAi33UBTBChC4Ac2fGDny2XPd+ifqAgbjZ27MMvdZ7TRCPMcZFm/k2
rh9oMhkkwCZmJQPUh2a7lTdVgFKgiOIXRCU6Zf4xygm67AFfNaGT/EtiStQpC81l
JN55snFv4PgOxNXAx/fM1rnwZj1GtxCMCAgDDp+0Y6WbX9XumaW9nAM=
-----END RSA PRIVATE KEY-----
EOF

# Imports certificates from other matchines
ssh-keyscan -H master.${DOMAIN_NAME} >> ~/.ssh/known_hosts
ssh-keyscan -H node01.${DOMAIN_NAME} >> ~/.ssh/known_hosts

## Here are the manual steps to copy the keys on the other servers ... (no more required)
#ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@master.giraffe-cloud.com
#ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@node01.giraffe-cloud.com

# Configure ssh access
#cp /home/vagrant/sync/ssh/id_rsa.pub /root/.ssh/id_rsa.pub
chown root:root /root/.ssh/id_rsa.pub
chmod 644 /root/.ssh/id_rsa.pub

#cp /home/vagrant/sync/ssh/id_rsa.pub /root/.ssh/authorized_keys
chown root:root /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

#cp /home/vagrant/sync/ssh/id_rsa /root/.ssh/id_rsa
chown root:root /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa

# Setup dnsmasq
yum -y install dnsmasq

# Configure dnsmasq
cat <<EOF >> /etc/dnsmasq.conf
strict-order
domain-needed
local=/${DOMAIN_NAME}/
bind-dynamic
resolv-file=/etc/resolv.conf.upstream
address=/.${DOMAIN_NAME}/$(hostname -I | cut -d' ' -f2)
log-queries
EOF

cat <<EOF > /etc/resolv.conf.upstream
nameserver 8.8.8.8
EOF

# Enable and start the dnsmasq service
systemctl enable dnsmasq
systemctl start dnsmasq

# Install the EPEL repository: 
yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# Disable the EPEL repository so that it is not accidentally used during later steps of the installation:
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

# Install the packages for Ansible: 
yum -y --enablerepo=epel install ansible

### Copy locally the installation scripts
cd ;git clone https://github.com/Maarc/openshift-ansible.git; cd openshift-ansible; git checkout -b 3.x v3.0.0-3

cat <<EOF > /etc/ansible/hosts
# Create an OSEv3 group that contains the masters and nodes groups
[OSEv3:children]
masters
nodes

# Set variables common for all OSEv3 hosts
[OSEv3:vars]
# SSH user, this user should allow ssh based auth without requiring a password
ansible_ssh_user=root

# If ansible_ssh_user is not root, ansible_sudo must be set to true
#ansible_sudo=true

# To deploy origin, change deployment_type to origin
deployment_type=enterprise

# enable htpasswd authentication
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/openshift/openshift-passwd'}]

# host group for masters
[masters]
master.${DOMAIN_NAME}

# host group for nodes, includes region info
# cf. https://github.com/openshift/openshift-ansible/blob/a7ac3f7b513fe57ddccad15bdb6c7e9091f16bcd/README_origin.md#overriding-detected-ip-addresses-and-hostnames
[nodes]
master.${DOMAIN_NAME} openshift_ip=${IP_PREFIX}.100 openshift_hostname=master.${DOMAIN_NAME} openshift_public_ip=${IP_PREFIX}.100 openshift_public_hostname=master.${DOMAIN_NAME}
node01.${DOMAIN_NAME} openshift_ip=${IP_PREFIX}.101 openshift_hostname=node01.${DOMAIN_NAME} openshift_public_ip=${IP_PREFIX}.101 openshift_public_hostname=node01.${DOMAIN_NAME}
EOF


# Setup authentication
mkdir -p /etc/openshift
touch /etc/openshift/openshift-passwd
htpasswd -b /etc/openshift/openshift-passwd ${HTTP_USER} ${HTTP_PASSWORD}