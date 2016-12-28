class php5fpm::opcache {
  php5fpm::extension { "opcache.ini":
    priority      => '5',
    template_path => 'php5fpm/opcache.ini.erb',
  }
}
