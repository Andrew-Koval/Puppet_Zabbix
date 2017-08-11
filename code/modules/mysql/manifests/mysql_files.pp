define mysql::mysql_files (
  $database = [],
  $source   = [], 
) {
  exec { 'dump':
    command => "/usr/bin/mysql -uroot $database < $source",
  }
}
