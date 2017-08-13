node default {
  include roles::zabbix_server
  include roles::zabbix_database
  include roles::zabbix_agent
}
