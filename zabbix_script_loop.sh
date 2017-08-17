#!/bin/bash

USERNAME='Admin'
PASSWORD='zabbix'
API_URL='https://zabbix.bazaarss.com/zabbix/api_jsonrpc.php'
ACTION_NAME=("Linux_Autoregistration" "Windows_Autoregistration" "MacOSX_Autoregistration" "FreeBSD_Autoregistration")
META_VALUE=("Linux" "Windows" "MacOS" "FreeBSD")
TEMPLATE_ID=("10001" "10081" "10079" "10075")

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
total=${#ACTION_NAME[*]}
  for (( i=0; i<=$(( $total -1 )); i++ ))
     do
	 curl -k -X POST -H 'Content-Type: application/json-rpc' -d '{
	    "jsonrpc": "2.0",
	    "method": "action.create",
	    "params": {
		"name": "'${ACTION_NAME[$i]}'",
		"eventsource": 2,
		"status": 0,
		"esc_period": 120,
		"filter": {
		    "evaltype": 0, 
		    "conditions": [
		        {
		            "conditiontype": 24,
		            "operator": 2,
		            "value": "'${META_VALUE[$i]}'"
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
		                 "templateid": "'${TEMPLATE_ID[$i]}'"
		               }
		       ]
		    }
		]    
	    },
	    "auth": "'$TOKENS'",
	    "id": 1
	}' $API_URL
  echo ${ACTION_NAME[$i]}
  echo ${META_VALUE[$i]}
  echo ${TEMPLATE_ID[$i]}
  done
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
