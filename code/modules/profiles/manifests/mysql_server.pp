class profiles::mysql_server {

  $db_name  = hiera('profiles::mysql_server::mysql_database::mysql_db::db_name')
  $user     = hiera('profiles::mysql_server::mysql_database::mysql_db::user')
  $password = hiera('profiles::mysql_server::mysql_database::mysql_db::password')
  $database = hiera('profiles::mysql_server::mysql_database::mysql_files::database')
  $source   = hiera('profiles::mysql_server::mysql_database::mysql_files::source')
  
  class { 'mysql_server':
    before => Mysql_database::Mysql_db['zabbix'],
}

  mysql_database::mysql_db {'zabbix':
    db_name  => $db_name,
    user     => $user,
    password => $password,
    require  => Class['mysql_server'],
    notify   => Service['zabbix-server'],
  }

  mysql_database::mysql_files {'schema':
    database => $database,
    source   => $source,
    require  => Mysql_database::Mysql_db['zabbix'],
    notify   => Service['zabbix-server'],
  }
}
