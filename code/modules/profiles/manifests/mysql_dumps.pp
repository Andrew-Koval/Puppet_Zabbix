class profiles::mysql_dumps {

  $database = hiera('profiles::mysql_database::mysql::mysql_files::database')
  $source1  = hiera('profiles::mysql_database::mysql::mysql_files::source1')
  $source2  = hiera('profiles::mysql_database::mysql::mysql_files::source2')
  $source3  = hiera('profiles::mysql_database::mysql::mysql_files::source3')
  $service  = hiera('profiles::mysql_database::mysql::mysql_files::service')
  $dump     = ["$source1", "$source2", "$source3"]

  notice ($dump)

  $dump.each |$schemas| {
    mysql::mysql_files{ $schemas: source => $schemas }
  }
}

  mysql::mysql_files {"$source":
    database => 'zabbix',
    source   => $source,
    service  => $service,
  }

  notice("MySQL dump $source is uploaded")

  class { 'profiles::mysql_dumps': }

