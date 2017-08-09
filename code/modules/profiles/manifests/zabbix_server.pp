class profiles::zabbix_server {

  class { 'zabbix_server::zabbix':
    before => Class['zabbix_server::zabbix_configs'],
  }

  class { 'zabbix_server::zabbix_configs':
    require => Class['zabbix_server::zabbix'],
  }
}
