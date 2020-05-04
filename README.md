This repo contains a cleanup script to remove the effects of the malware attack caused due to salt vulnerabilities on our platform.
The CVEs for the vulnerabilities are: 
- CVE-2020-11651
- CVE-2020-11652

## Steps to fix your device

- If you had `iptables` or `ufw` rules on the device, you need to manually add them back.
- Run `cleanup.sh` to undo the actions of the malware. 
- Verify that `/tmp/salt-minions` and `/var/tmp/salt-store` have been removed.
- Verify that `/var/spool/cron/crontabs/root` does not have any unknown entries.
- Check memory usage by using `free -mh` or `htop`. If the memory usage is not reduced, please do a reboot.


If you have apparmor enabled, execute the following to disable it from running, just in case:

- `profile salt-store /var/tmp/salt-store { }' | tee /etc/apparmor.d/salt-store`
- `apparmor_parser -r -W /etc/apparmor.d/salt-store`

If you had selinux enabled, please enabled it by running:

```
    rm /etc/selinux/config
    echo SELINUX=enabled >/etc/selinux/config
    setenforce 1
```

The `sa.txt` is the script that was run by the malware. Unfortunately, it's not possible to automate the recovery entirely. Here are a couple of points you need to look for:
- Your docker images might be removed and your running containers could be stopped. You'll need to install them again. 
- If you had any of the following packages, you will need to reinstall it:
   - aliyun
   - bcm-agent

Please contact support@rapyuta.io for any clarifications or help
