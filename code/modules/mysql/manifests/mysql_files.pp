define mysql::mysql_files (
  $database = 'zabbix',
  $source   = [], 
) {
  exec { "$source":
    command => "/usr/bin/mysql -uroot $database < $source",
    notify   => Service['zabbix-server'],
  }
}
