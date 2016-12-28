# PHP5-FPM FastCGI processing
class php5fpm(
  $php_packages   = $php5fpm::params::php_packages,
  $php_caching    = $php5fpm::params::php_caching,
  $php_fpm_config = $php5fpm::params::php_fpm_config,
  $php_ini_config = $php5fpm::params::php_ini_config,
) inherits ::php5fpm::params {

include $php_caching

## Move this package delcaration to params
  package { $php_packages:  
    ensure => installed,
  }
  service { 'php5-fpm':
    ensure => running,
  }

  file { "/etc/php5/fpm/php-fpm.conf":
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['php5-fpm'],
    content => template("php5fpm/${php_fpm_config}")
  }
  file { '/etc/php5/fpm/php.ini': 
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['php5-fpm'],
    content => template("php5fpm/${php_ini_config}")
  }
# Remove the 'www' pool that PHP5-FPM installs by default.
  file { "www.conf":
    ensure  => "absent",
    path    => "/etc/php5/fpm/pool.d/www.conf",
    notify  => Service['php5-fpm'],
  }
}
