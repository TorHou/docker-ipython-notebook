#!/bin/bash
CONF_LOCATION=/import/conf.yaml
# If there is a conf file
if [ -e "${CONF_LOCATION}" ]
then
    # And it lists a remote IP address
    HAS_REMOTE_IP=$(cat ${CONF_LOCATION} | grep "remote_host" | wc -l)
    if [[ "${HAS_REMOTE_IP}" -gt 0 ]];
    then
        # Apply some iptables rules to block all traffic except from this IP address
        REMOTE_IP=$(cat ${CONF_LOCATION} |  egrep -o 'remote_host: [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sed 's/.* //g')
        #Flush existing rules
        iptables -F
        # Set up default DROP rule for eth0
        iptables -P INPUT DROP
        # Allow existing connections to continue
        iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
        # Accept everything from the 192.168.1.x network
        iptables -A INPUT -i eth0 -s $REMOTE_IP -j ACCEPT
        # Allow connections from this host to 192.168.2.10
        iptables -A OUTPUT -o eth0 -d $REMOTE_IP -j ACCEPT
    fi
fi

/etc/init.d/cron start
ipython trust /import/ipython_galaxy_notebook.ipynb
ipython notebook --no-browser --ip=0.0.0.0 --port 6789 --profile=default
