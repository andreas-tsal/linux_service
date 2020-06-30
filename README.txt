
script location of host_info.sh:
/usr/bin/

create a system_service->host_info.service into: 
/etc/systemd/system/

After you make changes to your unit file, you should run systemctl daemon-reload

to start host_info web service, run
systemctl start host_info

To verify that the service is running, run
systemctl status host_info

To enable host_info service on boot up run
systemctl enable host_info

To disable host_info service on boot up run
systemctl disable host_info

To restart the service
systemctl restart host_info


create a log file->monitor.log into:
/var/log/host_info/

create a configuration Log File->host_info into:
/etc/logrotate.d/

Once your log file is in place force logrotate to rotate all logs with -f option.
sudo logrotate -f /etc/logrotate.conf





