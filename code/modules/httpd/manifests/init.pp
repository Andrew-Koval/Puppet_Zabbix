#
#  ==== Installation of Apache HTTPD Server with TLS certificates ====
#

class httpd (
  $https           = true,
  $listen          = ['80'],
  $namevirtualhost = [],
  $servername      = undef,
  $httpd_version   = 'latest',
  $service_restart = '/sbin/service httpd reload',
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

  if $https {
    package { 'mod_ssl':
      ensure => installed,
      notify => Service['httpd'],
    }

    package { 'openssl':
      ensure => 'installed',
    }

    file { '/etc/pki/tls/certs/bazaarss.crt':
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/httpd/bazaarss.crt',
      before => File['/etc/pki/tls/private/bazaarss.key'],
    }

    file { '/etc/pki/tls/private/bazaarss.key':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => 'puppet:///modules/httpd/bazaarss.key',
      require => File['/etc/pki/tls/certs/bazaarss.crt'],
    }

    file { '/etc/pki/tls/private/bazaarss.csr':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => 'puppet:///modules/httpd/bazaarss.csr',
      require => File['/etc/pki/tls/private/bazaarss.key'],
      notify  => Service['httpd'],
    }
  }
}
