# To make PHP5-FPM more modular, we define each extension as a resource.
# The templates for the configs are kept with the external module.
# This can be used in other modules (such as Memcache or Newrelic) with:
# php5fpm::extension { 'foobar.ini':
#   template_path     => 'foobar/foobar.ini.erb',
# }
define php5fpm::extension (
  $extension_dir  = $php5fpm::params::extension_dir,
  $priority       = "20",
  $template_path,
){
  file { "$name":
    ensure   => 'file',
    path     => "/etc/php5/$extension_dir/$name",
    owner    => '0',
    group    => '0',
    mode     => '0644',
    content  => template("$template_path"),
    notify   => Service['php5-fpm'],
  }
# The extension directory in Ubuntu 12.04 is a symlink:
# /etc/php5/conf.d -> ../conf.d/
# In Ubuntu 14.04, that directory is a hard link and the configs are symlinked.
# /etc/php5/fpm/conf.d/foo-bar.ini -> ../../mods-available/bar.ini
# This case statement handles instances of Ubuntu 14.04.
  if $::operatingsystem == 'Ubuntu' and $::operatingsystemrelease == '14.04' {
    file { "$priority-$name":
      ensure        => 'link',
      path          => "/etc/php5/fpm/conf.d/$priority-$name",
      target        => "../../$extension_dir/$name",
      notify        => Service['php5-fpm'],
    }
  }
}
