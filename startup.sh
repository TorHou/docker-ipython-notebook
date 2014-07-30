#!/bin/bash
CONF_LOCATION=/import/conf.yaml
# If there is a conf file
if [ -e "${CONF_LOCATION}" ]
then
    # Our gateway is the galaxy server
    GALAXY_HOST=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
    # Add this to the list of whitelisted IP addresses
    python /py/update_conf.py ${CONF_LOCATION} append whitelisted_ips ${GALAXY_HOST}
    # Fetch a list of whitelisted IPs
    WHITELISTED_IPS=$(python /py/update_conf.py ${CONF_LOCATION} read whitelisted_ips)
    # Count them
    NUM_IPS=$(echo -n $WHITELISTED_IPS | wc -c);
    if [[ "${NUM_IPS}" -gt 7 ]]; #7 = min ip len, e.g. 8.8.8.8
    then
        #Flush existing rules
        iptables -F
        # Set up default DROP rule for eth0
        iptables -P INPUT DROP
        # Allow existing connections to continue
        iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
        for ADDR in $WHITELISTED_IPS;
        do
            # Accept everything from the 192.168.1.x network
            iptables -A INPUT -i eth0 -s $ADDR -j ACCEPT
            # Allow connections from this host to 192.168.2.10
            iptables -A OUTPUT -o eth0 -d $ADDR -j ACCEPT
        done
    fi
fi

/etc/init.d/cron start
ipython trust /import/ipython_galaxy_notebook.ipynb
ipython notebook
