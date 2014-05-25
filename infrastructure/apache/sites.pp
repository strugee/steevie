class apache-sites {

  file { '/etc/apache2/ports.conf':
    ensure     => file,
    owner      => root,
    group      => root,
    source     => '/home/alex/Development/steevie/infrastructure/apache/ports.conf',
    #require    => Package['apache2'],
  }
  
  file { '/etc/apache2/sites-available/':
    ensure     => directory,
    recurse    => true,
    owner      => root,
    group      => root,
    source     => '/home/alex/Development/steevie/infrastructure/apache/sites-available',
    #require    => Package['apache2'],
  }

  file { '/etc/apache2/sites-enabled/000-default':
    ensure     => link,
    owner      => root,
    group      => root,
    mode       => 0777,
    target     => '../sites-available/default',
    #require    => Package['apache2'],
  }

  file { '/etc/apache2/sites-enabled/friendica':
    ensure     => link,
    owner      => root,
    group      => root,
    mode       => 0777,
    target     => '../sites-available/friendica',
    #require    => Package['apache2'],
  }

  #file { '/etc/apache2/sites-enabled

}

include apache-sites
