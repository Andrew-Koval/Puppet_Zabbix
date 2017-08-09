class httpd (
  $listen               = [ '80' ],
  $namevirtualhost      = [],
  $servername           = undef,
  $httpd_version        = 'latest',
  $service_restart      = '/sbin/service httpd reload',
) {

  package { 'httpd':
    ensure => $httpd_version,
  }

  file { '/etc/httpd/conf/httpd.conf':
    require => Package['httpd'],
    content => template('httpd/httpd.conf.erb'),
    notify  => Service['httpd'],
  }

  service { 'httpd':
    ensure    => running,
    enable    => true,
    restart   => $service_restart,
    hasstatus => true,
    require   => Package['httpd'],
  }
}
