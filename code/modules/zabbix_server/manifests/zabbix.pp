class zabbix_server::zabbix (
  $zabbix_src = 'http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm',
  $dbhost = 'localhost',
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
