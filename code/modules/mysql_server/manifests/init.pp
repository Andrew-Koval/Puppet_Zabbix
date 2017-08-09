class mysql_server {
  package { 'mysql-server':
    ensure => installed,
    before => Package['mysql'],
  }

  package { 'mysql':
    ensure  => installed,
    require => Package['mysql-server'],
  }

  service { 'mysqld':
    ensure    => running,
    enable    => true,
    require   => Package['mysql-server'],
  }
}
