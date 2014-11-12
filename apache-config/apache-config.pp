class { 'apache':
  default_mods         => false,
  default_confd_files  => false,
  package_ensure       => present,
  service_enable       => true,
  service_ensure       => running,
  default_vhost        => false,
  mpm_module           => 'prefork',
}

include apache::mod::dir
include apache::mod::autoindex
include apache::mod::mime
include apache::mod::negotiation
include apache::mod::setenvif
include apache::mod::deflate
include apache::mod::php
include apache::mod::ssl

apache::vhost { 'null.strugee.net plaintext':
  servername      => 'null.strugee.net',
  port            => '80',
  docroot         => '/srv/http/fallback/',
  redirect_status => 'permanent',
  redirect_dest	  => 'https://null.strugee.net/',
}

apache::vhost { 'null.strugee.net ssl':
  servername    => 'null.strugee.net',
  port          => '443',
  docroot       => '/srv/http/fallback/',
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/mailserver.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
}

apache::vhost { 'fallback catchall plaintext':
  servername      => 'redirect.null.strugee.net',
  port            => '80',
  docroot         => '/srv/http/fallback/',
  redirect_status => 'permanent',
  redirect_dest   => 'https://null.strugee.net',
  default_vhost   => true,
}

apache::vhost { 'fallback catchall ssl':
  servername    => 'redirect.null.strugee.net',
  port          => '443',
  docroot       => '/srv/http/fallback/',
  redirect_status => 'permanent',
  redirect_dest   => 'https://null.strugee.net',
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/mailserver.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
  default_vhost	=> true,
}

apache::vhost { 'strugee.net plaintext':
  servername      => 'strugee.net',
  port            => '80',
  docroot         => '/srv/http/default/',
  redirect_status => 'permanent',
  redirect_dest	  => 'https://strugee.net/',
}

apache::vhost { 'strugee.net ssl':
  servername    => 'strugee.net',
  port          => '443',
  docroot       => '/srv/http/default/',
  serveraliases => [
    'www.strugee.net',
    'ssh.strugee.net',
  ],
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/mailserver.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
}

apache::vhost { 'mail.strugee.net plaintext':
  servername      => 'mail.strugee.net',
  port            => '80',
  docroot         => '/srv/http/default/',
  redirect_status => 'permanent',
  redirect_dest	  => 'https://strugee.net/',
}

apache::vhost { 'mail.strugee.net ssl':
  servername    => 'mail.strugee.net',
  port          => '443',
  docroot       => '/srv/http/default/',
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/mailserver.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
}

apache::vhost { 'cloud.strugee.net plaintext':
  servername       => 'cloud.strugee.net',
  port        	   => '80',
  docroot	   => '/var/www/owncloud',
  redirect_status  => 'permanent',
  redirect_dest    => 'https://cloud.strugee.net/',
}

apache::vhost { 'cloud.strugee.net ssl':
  servername  	   => 'cloud.strugee.net',
  port		   => '443',
  docroot	   => '/var/www/owncloud',
  ssl 		   => true,
  ssl_cert	   => '/etc/ssl/certs/mailserver.pem',
  ssl_key	   => '/etc/ssl/private/mailserver.pem',
  block		   => 'scm',
  override	   => 'all',
  ssl_protocol     => 'all -SSLv2 -SSLv3',
}

apache::vhost { 'wiki.strugee.net plaintext':
  servername         => 'wiki.strugee.net',
  port               => '80',
  docroot            => '/var/lib/mediawiki',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://wiki.strugee.net/',
}

apache::vhost { 'wiki.strugee.net ssl':
  servername         => 'wiki.strugee.net',
  port               => '443',
  docroot            => '/var/lib/mediawiki',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/mailserver.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  directories        => [
    {
      path           => '/var/lib/mediawiki',
      provider       => 'directory',
      options        => ['+FollowSymLinks'],
      allow_override => 'all',
      order          => 'Allow,Deny',
      allow          => 'from all',
    },
    {
      path           => '/var/lib/mediawiki/config',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      php_admin_flag => 'engine off',
    },
    {
      path           => '/var/lib/mediawiki/images',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      php_admin_flag => 'engine off',
    },
    {
      path           => '/var/lib/mediawiki/upload',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      php_admin_flag => 'engine off',
    }
  ]
}
