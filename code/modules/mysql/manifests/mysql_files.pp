define mysql::mysql_files (
  $database = [],
  $source   = [],
) {
  exec { "$source":
    command => "/usr/bin/mysql -uroot $database < $source",
  }
}
