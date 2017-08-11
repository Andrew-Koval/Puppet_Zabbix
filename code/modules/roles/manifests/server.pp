class roles::server {
  include profiles::zabbix_server
  include profiles::mysql_server
  include profiles::mysql_database
  include profiles::httpd_server
  include profiles::zabbix_agent
}
