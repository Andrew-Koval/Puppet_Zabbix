define mysql_database::mysql_db (
  $db_name  = [],
  $user     = [],
  $password = [],
) {
  exec { 'create-database':
    command => "/usr/bin/mysql -uroot -e \"create database ${db_name} character set utf8 collate utf8_bin;\"",
    before  => Exec['grant-database-localhost'],
  }

  exec { 'grant-database-localhost':
    command => "/usr/bin/mysql -uroot -e \"grant all privileges on ${db_name}.* to ${user}@localhost identified by '$password';\"",
    require => Exec['create-database'],
  }

  exec { 'grant-database-remotehost':
    command => "/usr/bin/mysql -uroot -e \"grant all privileges on ${db_name}.* to ${user}@'%' identified by '$password';\"",
    require => Exec['grant-database-localhost'],
  }

  exec { 'flush-privilages':
    command => "/usr/bin/mysql -uroot -e \"flush privileges;\"",
    require => Exec['grant-database-remotehost'],
  }
}
