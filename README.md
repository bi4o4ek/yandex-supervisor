# Supervisor

This tool starts services if they unexpectedly stopped. It is use systemctl, so run it on up-to-date OS. For example, Ubuntu 15.04.

It is must be run as root

##Start examples
    ./supervisor.sh cron syslog
    nohup ./supervisor.sh cron syslog > /var/log/supervisor.log &

##Stop example
    pkill -f supervisor.sh

## TODO
Make this script runable through systemd as daemon.

## Other
Alternate way is using supervisord (http://supervisord.org/) or some SCM (Puppet/Chef)

Tested on Ubuntu 15.04, CentOS 7.0.1406
