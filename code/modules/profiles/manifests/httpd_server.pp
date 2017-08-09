class profiles::httpd_server {

  class { 'https':
    require => Class['zabbix_server::zabbix_configs'],
    before  => Class['httpd'],
  }

  class { 'httpd':
    require => Class['https'],
  }
}

