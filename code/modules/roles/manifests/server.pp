class roles::server {
  include profiles::zabbix_server
  include profiles::zabbix_database
  include profiles::mysql_dumps
  include profiles::httpd_server
  include profiles::zabbix_agent
}

