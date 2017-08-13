class roles::zabbix_server {
  include profiles::zabbix_server
  include profiles::httpd_server
}
