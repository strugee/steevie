package { 'apache2':
  ensure     => latest,
  before     => File['/etc/apache2/apache2.conf'],
}

file { '/etc/apache2/apache2.conf':
  ensure     => file,
  source     => '/home/alex/Development/steevie/infrastructure/apache/apache2.conf',
  mode       => '0644',
}

file { '/etc/apache2/sites-available/':
  ensure     => directory,
  recurse    => true,
  owner      => root,
  source     => '/home/alex/Development/steevie/infrastructure/apache/sites-available',
  require    => Package['apache2'],
}

file { '/etc/apache2/conf.d/':
  ensure     => directory,
  recurse    => true,
  owner      => root,
  source     => '/home/alex/Development/steevie/infrastructure/apache/conf.d/',
  require    => Package['apache2'],
}

service { 'apache2':
  ensure     => running,
  enable     => true,
  require    => Package['apache2'],
  subscribe  => [ File['/etc/apache2/apache2.conf'], File['/etc/apache2/conf.d'], File['/etc/apache2/sites-available'] ]
}
