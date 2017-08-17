#!/bin/bash

USERNAME='Admin'
PASSWORD='zabbix'
ACTION_NAME='Linux_Autoregistration'
API_URL='https://zabbix.bazaarss.com/zabbix/api_jsonrpc.php'
META_VALUE='Linux'
TEMPLATE_ID='10001'

authenticate() {
 curl -k -X POST -H 'Content-Type: application/json-rpc' -d '{
     "jsonrpc":"2.0",
     "method":"user.login",
     "params":{
         "user": "'$USERNAME'",
         "password": "'$PASSWORD'"},
         "id":1,
         "auth":null}' $API_URL | cut -c28-59
}

TOKENS=$(authenticate)

autoregistry() {
 curl -k -X POST -H 'Content-Type: application/json-rpc' -d '{
    "jsonrpc": "2.0",
    "method": "action.create",
    "params": {
        "name": "'$ACTION_NAME'",
        "eventsource": 2,
        "status": 0,
        "esc_period": 120,
        "def_shortdata": "Auto registration: {HOST.HOST}",
        "def_longdata": "Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}",
        "filter": {
            "evaltype": 0, 
            "conditions": [
                {
                    "conditiontype": 24,
                    "operator": 2,
                    "value": "'$META_VALUE'"
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
                         "templateid": "'$TEMPLATE_ID'"
                       }
               ]
            }
        ]    
    },
    "auth": "'$TOKENS'",
    "id": 1
}' $API_URL
}

output=$(autoregistry)

exit_code=$?

if [ $exit_code -ne 0 ]
   then
     	echo -e "Error in autoregistry creation\n"
        exit
   else
     	echo -e "\nCreation of autoregistry completed successfully\n"
        exit
fi
