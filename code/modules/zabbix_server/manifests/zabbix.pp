class zabbix_server::zabbix (
  $zabbix_src = [],
  $dbhost     = [],
) {
  package { 'zabbix_release':
    provider => 'rpm',
    ensure   => installed,
    source   => "$zabbix_src",
    before   => Package['zabbix-server'],
  }

  package { 'zabbix-server':
    ensure  => 'latest',
    require => Package['zabbix_release'],
  }

  package { 'zabbix-server-mysql':
    ensure  => 'installed',
    require => Package['zabbix-server'],
  }

  package { 'zabbix-web-mysql':
    ensure  => 'installed',
    require => Package['zabbix-server-mysql'],
  }

  file { '/etc/zabbix/zabbix_server.conf':
    require => Package['zabbix-server'],
    content => template('zabbix_server/zabbix_server.conf.erb'),
    notify  => Service['zabbix-server'],
  }

  service { 'zabbix-server':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['zabbix-server'],
  }
}
