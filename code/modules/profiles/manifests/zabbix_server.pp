class profiles::zabbix_server {

  $zabbix_src = hiera('profiles::zabbix_server::zabbix::zabbix_server::zabbix_src')
  $dbhost     = hiera('profiles::zabbix_server::zabbix::zabbix_server::dbhost')

  class { 'zabbix::zabbix_server':
    zabbix_src => $zabbix_src,
    dbhost     => $dbhost,
    before     => Class['zabbix::zabbix_configs'],
  }

  class { 'zabbix::zabbix_configs':
    require => Class['zabbix::zabbix_server'],
    notify  => Service['httpd'],
  }
}
