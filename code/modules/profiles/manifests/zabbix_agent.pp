class profiles::zabbix_agent {

  $server_active = hiera('profiles::zabbix_agent::zabbix::zabbix_agent::server_active')

  class { 'zabbix::zabbix_agent':
    server_active => $server_active,
  }
}
