#
#  ==== Uploading MySQL dumps to MySQL database for Zabbix Server ====
#

define mysql::mysql_files (
  $database,
  $source   = [],
  $table,
  $field,
  $value,
) {
  exec { $source:
    path    => ['/bin', '/usr/bin'],
    unless  => "echo `mysql -uroot -e 'use ${database}; select * from ${table} where ${field}=${value};'` | grep ${value}",
    command => "mysql -uroot ${database} < ${source}",
  }
}
