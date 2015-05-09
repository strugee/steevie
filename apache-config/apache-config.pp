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
include apache::mod::rewrite
include apache::mod::status
include apache::mod::expires
include apache::mod::headers
apache::mod { 'env': }
include apache::mod::cgi

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
  ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
}

apache::vhost { 'fallback catchall plaintext':
  servername      => 'redirect.null.strugee.net',
  port            => '80',
  docroot         => '/srv/http/fallback/',
  redirect_status => 'permanent',
  redirect_dest   => 'https://null.strugee.net/',
  default_vhost   => true,
}

apache::vhost { 'fallback catchall ssl':
  servername    => 'redirect.null.strugee.net',
  port          => '443',
  docroot       => '/srv/http/fallback/',
  redirect_status => 'permanent',
  redirect_dest   => 'https://null.strugee.net/',
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/mailserver.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
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
  ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
}

apache::vhost { 'mail.strugee.net plaintext':
  servername      => 'mail.strugee.net',
  port            => '80',
  docroot         => '/var/lib/roundcube/',
  redirect_status => 'permanent',
  redirect_dest	  => 'https://mail.strugee.net/',
}

apache::vhost { 'mail.strugee.net ssl':
  servername    => 'mail.strugee.net',
  port          => '443',
  docroot       => '/var/lib/roundcube/',
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/mailserver.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
  directories        => [
    {
      path           => '/var/lib/roundcube/',
      provider       => 'directory',
      options        => ['+FollowSymLinks'],
      allow_override => 'all',
      order          => 'Allow,Deny',
      allow          => 'from all',
    },
    {
      path           => '/var/lib/roundcube/config',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
    },
    {
      path           => '/var/lib/mediawiki/temp',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      order          => 'Allow,Deny',
      deny           => 'from all',
    },
    {
      path           => '/var/lib/roundcube/logs',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      order          => 'Allow,Deny',
      deny           => 'from all',
    }
  ],
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
  ssl_chain        => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher       => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block		   => 'scm',
  override	   => 'all',
  ssl_protocol     => 'all -SSLv2 -SSLv3',
  directories      => [
    {
      path           => '/var/www/owncloud',
      provider       => 'directory',
      options        => ['+FollowSymLinks'],
      allow_override => 'all',
    }
  ]
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
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  directories        => [
    {
      path           => '/var/lib/mediawiki',
      provider       => 'directory',
      options        => ['+FollowSymLinks'],
      allow_override => 'all',
      require        => 'all granted',
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
  ],
  rewrites           => [
    {
      rewrite_rule   => '^/?wiki(/.*)?$ %{DOCUMENT_ROOT}/index.php [L]',
    },
    {
      rewrite_rule   => '^/*$ %{DOCUMENT_ROOT}/index.php [L]',
    }
  ],
}

apache::vhost { 'bugzilla.strugee.net plaintext':
  servername         => 'bugzilla.strugee.net',
  port               => '80',
  docroot            => '/srv/http/bugzilla',
  docroot_group      => 'www-data',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://bugzilla.strugee.net/',
}

apache::vhost { 'bugzilla.strugee.net ssl':
  servername         => 'bugzilla.strugee.net',
  port               => '443',
  docroot            => '/srv/http/bugzilla',
  docroot_group      => 'www-data',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/mailserver.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  access_log_format  => '%v:%p %h %l %u %t \"%m %U\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"',
  directories        => [
    {
      path           => '/srv/http/bugzilla',
      provider       => 'directory',
      addhandlers    => [{ handler => 'cgi-script', extensions => ['.cgi']}],
      options        => ['+ExecCGI', '+FollowSymLinks'],
      allow_override => 'Limit FileInfo Indexes Options',
      directoryindex => 'index.cgi index.html',
    }
  ],
}

# apache::vhost { 'util.private.strugee.net plaintext':
#   servername         => 'util.private.strugee.net',
#   port               => '80',
#   docroot            => '/dev/null',
#   redirect_status    => 'permanent',
#   redirect_dest      => 'https://util.private.strugee.net/',
# }

# apache::vhost { 'util.private.strugee.net ssl':
#   servername         => 'util.private.strugee.net',
#   port               => '443',
#   docroot            => '/dev/null',
#   ssl                => true,
#   ssl_cert           => '/etc/ssl/certs/mailserver.pem',
#   ssl_key            => '/etc/ssl/private/mailserver.pem',
#   ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
#   block              => 'scm',
#   ssl_protocol       => 'all -SSLv2 -SSLv3',
#   directories        => [
#     {
#       path           => '/usr/share/phpmyadmin',
#       provider       => 'directory',
#       options        => ['FollowSymLinks'],
#       allow_override => 'all',
#       order          => 'Allow,Deny',
#       allow          => 'from all',
#     }
#   ]
# }

apache::vhost { 'isthefieldcontrolsystemdown.com plaintext':
  servername      => 'isthefieldcontrolsystemdown.com',
  port            => '80',
  docroot         => '/srv/http/isthefieldcontrolsystemdown.com/',
  serveraliases   => [
    'www.isthefieldcontrolsystemdown.com',
  ],
  block           => 'scm',
}

# apache::vhost { 'isthefieldcontrolsystemdown.com ssl':
#   servername    => 'isthefieldcontrolsystemdown.com',
#   port          => '443',
#   docroot       => '/srv/http/isthefieldcontrolsystemdown.com/',
#   serveraliases => [
#     'www.isthefieldcontrolsystemdown.com',
#   ],
#   ssl           => true,
#   ssl_cert      => '/etc/ssl/certs/mailserver.pem',
#   ssl_key       => '/etc/ssl/private/mailserver.pem',
#   ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
#   ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
#   block		=> 'scm',
#   ssl_protocol  => 'all -SSLv2 -SSLv3',
# }

apache::vhost { 'tumblr.strugee.net':
  servername      => 'tumblr.strugee.net',
  port            => '80',
  docroot         => '/var/empty',
  rewrites        => [ { rewrite_rule => ['^.*$ - [G]'] } ],
}
