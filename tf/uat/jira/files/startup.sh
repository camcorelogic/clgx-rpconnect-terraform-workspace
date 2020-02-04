#!/bin/bash
#
# GCP Terraform CLA cloudinit
#

#### Temp DNS
# Corelogic US manage clgx-network-nonprd, and Cloud DNS is setup to forward to AU domains
#cat << +++ > /etc/resolv.conf
#search ad.corelogic.asia rpdata.local google.internal
#nameserver 10.72.10.20
#nameserver 10.72.10.21
#+++
##
#### Perm DNS
## supersede domain-name-servers
#grep -iE '^supersede domain-name-servers' /etc/dhclient.conf || echo 'supersede domain-name-servers 10.72.10.20 10.72.10.21;' >> /etc/dhclient.conf
## supersede domain-search
#grep -iE '^supersede domain-search' /etc/dhclient.conf || echo 'supersede domain-search ad.corelogic.asia rpdata.local google.internal;' >> /etc/dhclient.conf
#

### Local users


### Local Service Account
groupadd -g 35000 ansible
useradd -u 35000 -g ansible -c 'ansible' -m -s /bin/bash ansible
mkdir /home/ansible/.ssh && chown ansible:ansible /home/ansible/.ssh && chmod 700 /home/ansible/.ssh
cat << +++ > /home/ansible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAt3t7PcJKXim7VZpVIrCjecP1GUjmLf6jYMp0ce4bSOSaSYju3e+IbY4Eeg5+pE6CrU8jdlbGi/zH539+40h9TLb7OuiWyJr5Z6Lf7rL0rOOuIKz9LS3ZWajcT7wC9ntO+40UO4+8fOh+/anL/iDGv1+CKzMihEeUT1+oDitCTlwtzLiF7RZkYibdUlFScGkmlyci4UcuJI0ccvMjnVo7yk3mT42emrDf0AvAx/oP2+qC64vZ4mjx/HRkgBaQ50E7kTJ3qP/NAArjTP86RzXvzbo9XhGpCIDykrwjT82uGfzRGMZGe8fxj5jZqnZ6fgX1fDxla8m+6bp1UuPs50wKrnBrnl5MhLlUP9xQh6v+CK37qaW0BxdrawvhDMsACqMfL4igDrKKALr7ArpswyJuxB11TOFkhNRO7cJy1I7zWOEBuVgKDU0v+RL5cUleRrMiFqXKYAy6H1H4HVWOqIUpaZckQPe2X5LQ6d9JbpFuJfSgXQbPwsJe+zQtoUvtkiTNYLGVEpj4SNHW070STBg6dHGsMUCPV3/L0vm1EAUmNtoKbKsmSUhsANrTLZsnQBfOn2L9xYl5IRAJW9dq3GQSO3fi4ibr2TcJkG2p4dc5wwzGsMH7ljGjObnvV0Vt8LVv4bGZqTlW1bAFfIgezeqsTzxZZkZHI5neUpgilJyhKjs= ansible@corelogic-asia
+++
chmod 600 /home/ansible/.ssh/authorized_keys ; chown ansible:ansible /home/ansible/.ssh/authorized_keys

### Local Service Account
groupadd -g 35002 zenoss
useradd -u 35002 -g zenoss -c 'zenoss' -m -s /bin/bash zenoss
mkdir /home/zenoss/.ssh && chown zenoss:zenoss /home/zenoss/.ssh && chmod 700 /home/zenoss/.ssh
cat << +++ > /home/zenoss/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKkKAJa4IYmrr9Cr5nOEe5mDMcGvJal+/RYls7mYHRyb3kBMZMSAGqQqFPefkdOZTpbzkof0SAoUNGRuGBQBJyNqXclLw0fDsYhNdiAnDU+S6QvOEwQ65FZYkIj22Leuneo1zIHgxtgXplr7VsGED9sPt0hHUhvaLxL9IhU26iTlVOU4RfC+nI7yZYywEw6SpO/mh1ylOJafVCQz66MlLsjjGH+QXpZcCswc88lqMwEB4rUW6NRaBS4k21Ov/G878t50NHSXh6y6WWykWq416CP5/5Xq+LSBm11wGvXUu7F0pgJruwiqbi6bIgFIAg+R+BX4J531ZPHZeVZ4NsZW8t zenoss@bpplin01-zenoss.ad.corelogic.asia
+++
chmod 600 /home/zenoss/.ssh/authorized_keys ; chown zenoss:zenoss /home/zenoss/.ssh/authorized_keys


### Sudoers
cat << +++ > /etc/sudoers.d/ansible_sudoers

## Ansible service account
ansible        ALL=(ALL)       NOPASSWD: ALL

+++
chmod 440 /etc/sudoers.d/ansible_sudoers

## ZenOSS monitoring account
cat << +++ > /etc/sudoers.d/zenoss_sudoers

Defaults:zenoss !requiretty
Cmnd_Alias ZENOSS_LVM_CMDS = /sbin/pvs, /sbin/vgs, /sbin/lvs, /usr/sbin/pvs, /usr/sbin/vgs, /usr/sbin/lvs
Cmnd_Alias ZENOSS_SVC_CMDS = /bin/systemctl list-units *, /bin/systemctl status *, /sbin/initctl list, /sbin/service --status-all, /usr/sbin/dmidecode, /bin/df
zenoss ALL=(ALL) NOPASSWD: ZENOSS_LVM_CMDS, ZENOSS_SVC_CMDS

+++
chmod 440 /etc/sudoers.d/zenoss_sudoers


### CLA YUM repos 
yum -y install curl
curl http://yum.ad.corelogic.asia/cla.repo > /etc/yum.repos.d/cla.repo

### CLA SOE packages
yum -y install lvm2
yum -y install bind-utils telnet lsof unzip mailx nc
yum -y install krb5-workstation samba-common-tools sssd-ad

### Puppet
# sudo rpm -Uvh http://yum.puppet.com/puppet5-release-el-7.noarch.rpm
yum -y install puppet-agent 
/bin/systemctl enable puppet
/bin/systemctl start puppet


### CLA sshd_config override to allow AD password logins
cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config.orig
sed -i "s/^PasswordAuthentication/# CLA PasswordAuthentication/" /etc/ssh/sshd_config
systemctl restart sshd


#### Per patching outside startup script

#### Stackdriver agent install
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh -O /tmp/install-monitoring-agent.sh && bash /tmp/install-monitoring-agent.sh
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh -O /tmp/install-logging-agent.sh && bash install-logging-agent.sh



