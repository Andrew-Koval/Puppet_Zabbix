class profiles::httpd_server {

  class { 'https':
    before  => Class['httpd'],
  }

  class { 'httpd':
    require => Class['https'],
  }
}
