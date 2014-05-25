file { '/srv/http':
  ensure => directory,
  owner => root,
  group => root,
  mode => 0755,
}

file { '/srv/http/default':
  ensure => directory,
  owner  => root,
  group  => root,
  mode   => 0755,
}

file { '/srv/http/friendica':
  ensure => directory,
  owner  => root,
  group  => root,
  mode   => 0755,
}
