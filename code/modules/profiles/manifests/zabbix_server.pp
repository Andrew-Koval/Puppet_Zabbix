class profiles::zabbix_server {

  $zabbix_src = hiera('profiles::zabbix_server::zabbix_server::zabbix::zabbix_src')
  $dbhost     = hiera('profiles::zabbix_server::zabbix_server::zabbix::dbhost')

  class { 'zabbix_server::zabbix':
    zabbix_src => $zabbix_src,
    dbhost     => $dbhost,
    before     => Class['zabbix_server::zabbix_configs'],
  }

  class { 'zabbix_server::zabbix_configs':
    require => Class['zabbix_server::zabbix'],
    notify  => Service['httpd'],
  }
}
