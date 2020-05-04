#!/bin/bash

sed -i '/54.36/d' /var/spool/cron/crontabs/root

ps aux | grep -e "/var/tmp/salt-store\|salt-minions" | grep -v grep | tr -s " " | cut -d " " -f 2 | xargs -n 1 -I{} kill -9 {}
rm /tmp/salt-minions
rm /var/tmp/salt-store

sed -i '/kernel.nmi_watchdog/d' /etc/sysctl.conf
systemctl restart firewalld || /etc/init.d/iptables restart

