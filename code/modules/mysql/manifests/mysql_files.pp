define mysql::mysql_files (
  $database = [],
  $source   = [],
  $service  = [],
) {
  exec { "$source":
    command => "/usr/bin/mysql -uroot $database < $source",
    notify  => Service["$service"],
  }
}
