file { '/srv/http':
  ensure => directory,
  owner => root,
  group => root,
  mode => 0600
}

file { '/srv/http/default':
  ensure => directory,
}
