# Create PHP5-FPM processor pools. 
define php5fpm::pool (
  $php_name               = "${name}",
  $php_port               = undef,
  $php_newrelic_appname   = undef,
  $php_status_path        = "/fpm-status-${name}",
  $php_ping_path          = "/ping-${name}",
){
	
  file { "${title}.conf pool config":
    ensure  => "present",
    path    => "/etc/php5/fpm/pool.d/${title}.conf",
    notify  => Service['php5-fpm'],
    content => template("php5fpm/php_pool.erb"),
   }
}
