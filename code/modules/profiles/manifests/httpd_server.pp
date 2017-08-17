class profiles::httpd_server {

  class { 'httpd': }

  exec { 'zabbix_script':
    command => '/etc/zabbix/zabbix_script.sh',
    refreshonly => true,
  }
}

