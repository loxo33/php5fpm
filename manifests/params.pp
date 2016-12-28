class php5fpm::params {

  $php_ini_config = $::operatingsystemrelease ? {
    "12.04"     => "php_ini_1204.erb",
    "14.04"     => "php_ini_1404.erb",
    default     => "php_ini_default.erb",
  }
  $php_fpm_config = $::operatingsystemrelease ? {
    "12.04"     => "php_fpm_1204.erb",
    "14.04"     => "php_fpm_1404.erb",
    default     => "php_fpm_default.erb",
  }
  $php_cachng = $::operatingsystemrelease ? {
    "12.04"     => "php5fpm::apc",
    "14.04"     => "php5fpm::opcache",
    default     => "php_fpm_default.erb",
  }
  $extension_dir = $::operatingsystemrelease ? {
    "12.04"     => "conf.d",
    "14.04"     => "mods-available",
    default     => "conf.d"
  }
  $php_packages = $::operatingsystemrelease ? {
    "12.04"    => ['php5-fpm','php5-curl','php5-gd',
                   'php5-cli','php-apc','php5-mcrypt',
                   'php5-mysql','php5-suhosin',],
    "14.04"    => ['php5-fpm','php5-curl','php5-gd',
                   'php5-cli','php5-mcrypt','php5-mysql',],
    default    => ['php-fpm',],
  }
}
