#!/bin/bash

ZABBIX_USER='Admin'
ZABBIX_PASS='zabbix'
ACTION_NAME='Linux_Host_Auto_Registration'
API='https://zabbix.bazaarss.com/zabbix/api_jsonrpc.php'

service zabbix-agent stop

authenticate() {
  curl -i -k -X POST -H 'Content-Type: application/json-rpc' -d '{"jsonrpc":"2.0", "method":"user.login", "params":{"user":"'$ZABBIX_USER'", "password":"'$ZABBIX_PASS'"}, "id":1, "auth":null}' $API
}

AUTH_TOKEN=$(authenticate)

autoregistry() {
  curl -i -k -X POST -H 'Content-Type: application/json-rpc' -d '{"jsonrpc": "2.0", "method": "action.create", "params":{"name":"'$ACTION_NAME'", "eventsource": 2, "status": 0, "esc_period": 120, "filter":{"conditions":[{"conditiontype": 24, "operator": 0, "value": "Linux"}]}, "operations": [{"operationtype": 2}, {"operationtype": 6, "optemplate":[{"templateid": "10001"}]}]}, "auth": "'$AUTH_TOKEN'", "id":1}' $API
}

output=$(autoregistry)

exit_code=$?

if [ $exit_code -ne 0 ]
 then
     	echo -e "Error in autoregistry creation at `date`:\n"
        exit
 else
     	echo -e "\nCreation of autoregistry completed successfully at `date`:, starting Zabbix Agent\n"
        service zabbix-agent start
        exit
 fi
