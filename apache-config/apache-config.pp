class { 'apache':
  default_mods         => false,
  default_confd_files  => false,
  package_ensure       => present,
  service_enable       => true,
  service_ensure       => running,
  default_vhost        => false,
}

include apache::mod::dir
include apache::mod::autoindex
include apache::mod::mime
include apache::mod::negotiation
include apache::mod::setenvif
include apache::mod::deflate

apache::vhost { 'strugee.net':
  port     => 80,
  docroot  => '/srv/http/default/',
}

apache::vhost { 'www.strugee.net':
  port     => 80,
  docroot  => '/srv/http/default/',
}

apache::vhost { 'ssh.strugee.net':
  port     => 80,
  docroot  => '/srv/http/default/',
  default_vhost => true,
}
