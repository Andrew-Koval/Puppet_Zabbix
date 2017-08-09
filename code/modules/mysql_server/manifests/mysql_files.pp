class mysql_server::mysql_files (
  $db_name  = 'zabbix',
) {
  exec { "schema.mysql":
    command => "/usr/bin/mysql -uroot $db_name < /usr/share/doc/zabbix-server-mysql-2.4.8/create/schema.sql",
    require => Service["mysqld"],
  }

  exec { "images.mysql":
    command => "/usr/bin/mysql -uroot $db_name < /usr/share/doc/zabbix-server-mysql-2.4.8/create/images.sql",
    require => Service["mysqld"],
  }

  exec { "data.mysql":
    command => "/usr/bin/mysql -uroot $db_name < /usr/share/doc/zabbix-server-mysql-2.4.8/create/data.sql",
    require => Service["mysqld"],
  }
}
