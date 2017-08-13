class profiles::zabbix_database {

  $db_name  = hiera('profiles::mysql_server::mysql::mysql_db::db_name')
  $user     = hiera('profiles::mysql_server::mysql::mysql_db::user')
  $password = hiera('profiles::mysql_server::mysql::mysql_db::password')

  class { 'mysql::mysql_server':
    before => Mysql::Mysql_database['zabbix'],
  }

  mysql::mysql_database {"$db_name":
    db_name  => $db_name,
    user     => $user,
    password => $password,
    require  => Class['mysql::mysql_server'],
    notify   => Service['zabbix-server'],
  }
}
