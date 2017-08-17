class zabbix::zabbix_configs {
  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zabbix/zabbix.conf.erb'),
  }

  file { '/var/log/httpd/zabbix.log':
    ensure  => 'present',
    replace => 'no',
    mode    => '0644',
  }

  file { '/var/log/httpd/zabbix.err':
    ensure  => 'present',
    replace => 'no',
    mode    => '0644',
  }

  file { 'zabbix_script.sh':
    ensure => 'file',
    source => 'puppet:///modules/zabbix/zabbix_script.sh',
    path   => '/etc/zabbix/zabbix_script.sh',
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    notify => Exec['zabbix_script'],
  }
}
