class profiles::mysql_dumps {

  $database = hiera('profiles::mysql_database::mysql::mysql_files::database')
  $source   = hiera_array('profiles::mysql_database::mysql::mysql_files::source')
  $dump     = ["$source"]

  notice ($dump)

    $dump.slice |$schemas| {
    mysql::mysql_files { $schemas:
      database => $database,
      source   => $schemas,
      notify   => Service['zabbix-server'],
    }
    notice("MySQL dump $schemas is uploaded")
    }
}
