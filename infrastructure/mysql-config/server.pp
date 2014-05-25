class { '::mysql::server':
  root_password            => 'strong password',
  manage_config_file       => true,
  restart                  => true,
  package_ensure           => present,
  package_name             => 'mysql-server',
  remove_default_accounts  => true,
  service_enabled          => true,
  service_manage           => true,
  service_name             => 'mysql',
  override_options         => {
    'mysqld' => { 'max_connections' => '1024' },
  },
}
