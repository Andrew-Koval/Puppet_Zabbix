class profiles::mysql_dumps {

  $database = hiera('profiles::mysql_database::mysql::mysql_files::database')
  $source   = hiera('profiles::mysql_database::mysql::mysql_files::source')

  notice ($dump)

    $source.each |$schemas| {
    mysql::mysql_files { $schemas:
      database => $database,
      source   => $schemas,
      notify   => Service['zabbix-server'],
    }
    notice("MySQL dump $schemas is uploaded")
    }
}
