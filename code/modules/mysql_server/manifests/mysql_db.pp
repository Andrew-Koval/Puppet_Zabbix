class mysql_server::mysql_db (
  $db_name    = 'zabbix',
  $user       = 'zabbix',
  $password   = 'zabbix',
  $localhost  = 'localhost',
  $remotehost = '%',
) {
  exec { "create-database":
    command => "/usr/bin/mysql -uroot -e \"create database ${db_name} character set utf8 collate utf8_bin;\"",
    require => Service["mysqld"],
  }

  exec { "grant-database-localhost":
    command => "/usr/bin/mysql -uroot -e \"grant all privileges on ${db_name}.* to ${user}@${localhost} identified by '$password';\"",
    require => [Service["mysqld"], Exec["create-database"]],
  }

  exec { "grant-database-remotehost":
    command => "/usr/bin/mysql -uroot -e \"grant all privileges on ${db_name}.* to ${user}@${remotehost} identified by '$password';\"",
    require => [Service["mysqld"], Exec["grant-database-localhost"]],
  }

  exec { "flush-privilages":
    command => "/usr/bin/mysql -uroot -e \"flush privileges;\"",
    require => [Service["mysqld"], Exec["grant-database-remotehost"]],
  }
}
