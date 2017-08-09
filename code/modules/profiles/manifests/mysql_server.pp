class profiles::mysql_server {

  class { 'mysql_server::mysql':
    before  => Class['mysql_server::mysql_db'],
    require => Class['zabbix_server::zabbix_configs'],
  }

  class { 'mysql_server::mysql_db':
    require => Class['mysql_server::mysql'],
  }

  class { 'mysql_server::mysql_files':
    require => Class['mysql_server::mysql_db'],
  }
}
