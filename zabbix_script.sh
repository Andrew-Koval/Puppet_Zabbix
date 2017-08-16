#!/bin/bash

ZABBIX_USER='Admin'
ZABBIX_PASS='zabbix'
ACTION_NAME='Linux_Host_Auto_Registration'
API='https://zabbix.bazaarss.com/zabbix/api_jsonrpc.php'

authenticate() {
 curl -i -k -X POST -H 'Content-Type: application/json-rpc' -d '{
     "jsonrpc":"2.0",
     "method":"user.login",
     "params":{
         "user": "'$ZABBIX_USER'",
         "password": "'$ZABBIX_PASS'"},
         "id":1,
         "auth":null}' $API | tail -n 1 | cut -c28-59
}

AUTH_TOKEN=$(authenticate)
echo $AUTH_TOKEN

autoregistry() {
 curl -i -k -X POST -H 'Content-Type: application/json-rpc' -d '{
    "jsonrpc": "2.0",
    "method": "action.create",
    "params": {
        "name": "Linux Host Auto Registration",
        "eventsource": 2,
        "status": 0,
        "esc_period": 120,
        "filter": {
            "evaltype": 0, 
            "conditions": [
                {
                    "conditiontype": 24,
                    "operator": 0,
                    "value": "Linux"
                }
            ]
        },
        "operations": [
            {
                "operationtype": 2
            },
            {
                "operationtype": 6,
                "optemplate": [
                       {
                         "templateid": "10001"
                       }
               ]
            }
        ]    
    },
    "auth": "'$AUTH_TOKEN'",
    "id": 1
}' $API
}

output=$(autoregistry)

exit_code=$?

if [ $exit_code -ne 0 ]
 then
     	echo -e "Error in autoregistry creation at `date`:\n"
        exit
 else
     	echo -e "\nCreation of autoregistry completed successfully at `date`:, starting Zabbix Agent\n"
        exit
 fi
