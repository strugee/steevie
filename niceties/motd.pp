file { 'motd':
  ensure   => present,
  path     => '/etc/motd',
  mode     => '0644',
  content  => "Welcome to steevie!",
}
