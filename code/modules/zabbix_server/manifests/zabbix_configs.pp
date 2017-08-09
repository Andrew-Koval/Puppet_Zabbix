class zabbix_server::zabbix_configs {
  file { '/etc/httpd/conf.d/zabbix.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zabbix_server/zabbix.conf.erb'),
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
}
