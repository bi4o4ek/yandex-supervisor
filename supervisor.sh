#!/usr/bin/env bash

# author: Vladimir Bykanov
# email: vladimir@bykanov.ru
#
# This tool starts services if they unexpectedly stopped
# It is must be run as root
# Start examples:
#     ./supervisor.sh cron syslog
#     nohup ./supervisor.sh cron syslog > /var/log/supervisor.log &
#
# Stop example: pkill -f supervisor.sh
#
# TODO: Make this script runable through systemd as daemon.
#
# Alternate way is using supervisord (http://supervisord.org/) or some SCM (Puppet/Chef)
#
# Tested on Ubuntu 15.04, CentOS 7.0.1406

# Set additional bash checks
set -o errexit
set -o nounset
set -o pipefail

# Use systemctl because this is very portable
CMD='/usr/bin/env systemctl'

# Time interval between checks
CHECK_INTERVAL=2

# Date format: 21/May/2015:12:27:48 +0300
FMT="+'%d/%b/%Y:%H:%M:%S %z'"
DATE="/usr/bin/env date"

# Help message
display_usage() {
    echo
    echo "Usage: ${0} [-h] <service> ..." 
}

if ! $CMD --version &>/dev/null; then
    echo 'Could not find systemctl. Upgrade you OS please.'
    exit 1
fi

if [  $# -eq 0 ] || [ "${1}" = '--help' ] || [ "${1}" = '-h' ]; then
    display_usage
    exit 0
fi

SERVICES="${@}"

# Work like a daemon
while true; do
    for service in $SERVICES; do

        # If service is ok, then do nothing
        if $CMD is-active --quiet $service; then
            continue
        fi

        # ...else try to start service
        echo $($DATE "${FMT}") "The service ${service} is not running. Respawning.."

        if $CMD start $service &>/dev/null; then
            echo $($DATE "${FMT}") "The service ${service} has started successfully."
        else
            echo $($DATE "${FMT}") "Could not run the service ${service}."
        fi
    done

    sleep "${CHECK_INTERVAL}"
done

