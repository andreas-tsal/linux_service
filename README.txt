
script location of host_info.sh:
home/"user"/host_info.sh 

create a system_service->host_info.service into: 
/etc/systemd/system/

create a log file->monitor.log into:
/var/log/host_info/

create a configuration Log File->host_info into:
/etc/logrotate.d/
Once your log file is in place force logrotate to rotate all logs with -f option.
sudo logrotate -f /etc/logrotate.conf



