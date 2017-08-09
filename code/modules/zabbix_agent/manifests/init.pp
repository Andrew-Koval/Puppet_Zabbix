class zabbix_agent (
  $server_active = '127.0.0.1',
){
  package { 'zabbix-agent':
    ensure  => 'latest',
  }

  file { '/etc/zabbix/zabbix_agentd.conf':
    require => Package['zabbix-agent'],
    content => template('zabbix_agent/zabbix_agentd.conf.erb'),
    notify  => Service['zabbix-agent'],
  }

  service { 'zabbix-agent':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['zabbix-agent'],
  }
}
