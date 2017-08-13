class roles::zabbix_database {
  include profiles::zabbix_database
  include profiles::mysql_dumps
}
