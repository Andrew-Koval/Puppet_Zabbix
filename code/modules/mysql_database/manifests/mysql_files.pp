define mysql_database::mysql_files (
  $database = [],
  $source   = [], 
) {
  exec { 'schema.mysql':
    command => "/usr/bin/mysql -uroot $database < $source/schema.sql",
  }

  exec { 'images.mysql':
    command => "/usr/bin/mysql -uroot $database < $source/images.sql",
  }

  exec { 'data.mysql':
    command => "/usr/bin/mysql -uroot $database < $source/data.sql",
  }
}
