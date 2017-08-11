class profiles::mysql_database {

  $database = hiera('profiles::mysql_database::mysql::mysql_files::database')
  $source   = hiera('profiles::mysql_database::mysql::mysql_files::source')
  $dump     = ["$source"]

  notice ($dump)

  $dump.each |$schemas|
    {
     mysql::mysql_files{ $schemas: source => $schemas }
    }
}
  
  mysql::mysql_files(
    $source = $src
  ) {'dumps':
      database => $database,
      source   => $source,
      notify   => Service['zabbix-server'],
    }

  notice("MySQL dump $src is uploaded")

  class { 'profiles::mysql_database': }
