class php5fpm::apc {
  php5fpm::extension { "apc.ini":
    priority      => '5',
    template_path => 'php5fpm/apc.ini.erb',
  }
}
