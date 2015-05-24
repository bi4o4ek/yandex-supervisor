# Supervisor

This tool starts services if they unexpectedly stopped

It is must be run as root

##Start examples:
    ./supervisor.sh cron syslog
    nohup ./supervisor.sh cron syslog > /var/log/supervisor.log &

##Stop example:
    pkill -f supervisor.sh

## TODO:
Make this script runable through systemd as daemon.


Alternate way is using supervisord (http://supervisord.org/) or some SCM (Puppet/Chef)

Tested on Ubuntu 15.04, CentOS 7.0.1406
