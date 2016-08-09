class wordpress_app::database_profile (
  # Must only be set with lookup or Wordpress_app::Database produces Database will be wrong
  String $port,
  String $bind_address = '0.0.0.0',
) {

  # If $port doesn't match the lookup value this should fail to prevent inaccurate
  # database capabilities.
  if ($port != lookup('wordpress_app::database_profile::port')) {
    fail("\$wordpress_app::database_profile::port can only be set via puppet lookup.")
  }

  notify {"port is getting ${port}": }
  class { 'mysql::server':
    override_options => {
      'mysqld'       => {
        'bind_address' => '0.0.0.0',
        'port'         => '3306',
      },
    },
  }
  firewall { '3306 allow apache-mysql':
    dport  => ['3306'],
    proto  => tcp,
    action => accept,
  }
}
