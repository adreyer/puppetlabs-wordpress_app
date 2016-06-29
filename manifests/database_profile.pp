class wordpress_app::database_profile (
  String $bind_address = '0.0.0.0',
  String $port         = '3306',
) {
  class { 'mysql::server':
     override_options => {
       'mysqld'       => {
         'bind_address' => '0.0.0.0',
         'port'         => $port,
       },
     },
  }
  firewall { '${port} allow apache-mysql':
    dport  => [$port],
    proto  => tcp,
    action => accept,
  }
}
