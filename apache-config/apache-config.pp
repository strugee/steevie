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
include apache::mod::proxy
include apache::mod::proxy_http
include apache::mod::proxy_balancer
apache::mod { 'lbmethod_byrequests': }
# This is a bug in Apache
apache::mod { 'slotmem_shm': }
apache::mod { 'proxy_wstunnel': }
include apache::mod::alias
include apache::mod::passenger
include apache::mod::wsgi

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
  ssl_cert      => '/etc/ssl/certs/null.strugee.net.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
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
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
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
  redirect_source => ['/.well-known/webdav', '/.well-known/caldav', '/.well-known/carddav'],
  redirect_status => ['temp', 'temp', 'temp'],
  redirect_dest => ['https://cloud.strugee.net/remote.php/webdav/', 'https://cloud.strugee.net/remote.php/caldav/', 'https://cloud.strugee.net/remote.php/carddav/'],
  ssl           => true,
  ssl_cert      => '/etc/ssl/certs/www.strugee.net.pem',
  ssl_key       => '/etc/ssl/private/mailserver.pem',
  ssl_chain     => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher    => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block		=> 'scm',
  ssl_protocol  => 'all -SSLv2 -SSLv3',
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
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
  ssl_cert      => '/etc/ssl/certs/mail.strugee.net.pem',
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
      require        => 'all granted',
    },
    {
      path           => '/var/lib/roundcube/config',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
    },
    {
      path           => '/var/lib/roundcube/temp',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      require        => 'all denied',
    },
    {
      path           => '/var/lib/roundcube/logs',
      provider       => 'directory',
      options        => ['-FollowSymLinks'],
      allow_override => 'none',
      require        => 'all denied',
    }
  ],
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
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
  redirect_source  => ['/.well-known/webdav', '/.well-known/caldav', '/.well-known/carddav'],
  redirect_status  => ['temp', 'temp', 'temp'],
  redirect_dest    => ['https://cloud.strugee.net/remote.php/webdav/', 'https://cloud.strugee.net/remote.php/caldav/', 'https://cloud.strugee.net/remote.php/carddav/'],
  ssl 		   => true,
  ssl_cert	   => '/etc/ssl/certs/cloud.strugee.net.pem',
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
  ],
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
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
  ssl_cert           => '/etc/ssl/certs/wiki.strugee.net.pem',
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
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
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
  ssl_cert           => '/etc/ssl/certs/bugzilla.strugee.net.pem',
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
      allow_override => 'Limit FileInfo Indexes Options AuthConfig',
      directoryindex => 'index.cgi index.html',
    }
  ],
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'piwik.strugee.net plaintext':
  servername         => 'piwik.strugee.net',
  port               => '80',
  docroot            => '/srv/http/piwik',
  docroot_group      => 'www-data',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://piwik.strugee.net/',
}

apache::vhost { 'piwik.strugee.net ssl':
  servername         => 'piwik.strugee.net',
  port               => '443',
  docroot            => '/srv/http/piwik',
  docroot_group      => 'www-data',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/piwik.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  access_log_format  => '%v:%p %h %l %u %t \"%m %U\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"',
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'etherpad.strugee.net plaintext':
  servername         => 'etherpad.strugee.net',
  port               => '80',
  docroot            => '/srv/http/etherpad',
  docroot_group      => 'www-data',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://etherpad.strugee.net/',
}

apache::vhost { 'etherpad.strugee.net ssl':
  servername         => 'etherpad.strugee.net',
  port               => '443',
  docroot            => '/srv/http/etherpad',
  docroot_group      => 'etherpad',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/etherpad.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  access_log_format  => '%v:%p %h %l %u %t \"%m %U\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"',
  proxy_pass         => [
    { 'path' => '/', 'url' => 'http://localhost:9001/',
      'reverse_urls' => 'http://localhost:9001' },
  ],
  proxy_preserve_host => true,
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'pump.strugee.net plaintext':
  servername         => 'pump.strugee.net',
  port               => '80',
  docroot            => '/var/empty',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://pump.strugee.net/',
}

apache::vhost { 'pump.strugee.net ssl':
  servername         => 'pump.strugee.net',
  port               => '443',
  docroot            => '/var/empty',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/pump.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  access_log_format  => '%v:%p %h %l %u %t \"%m %U\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"',
  ssl_proxyengine    => true,
  proxy_pass         => [
    { 'path' => '/main/realtime/sockjs', 'url' => 'ws://localhost:31337/main/realtime/sockjs',
      'reverse_urls' => 'http://localhost:31337/main/realtime/sockjs' },
    { 'path' => '/', 'url' => 'https://localhost:31337/',
      'reverse_urls' => 'https://localhost:31337/' },
  ],
  proxy_preserve_host => true,
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'friendica.strugee.net plaintext':
  servername         => 'friendica.strugee.net',
  port               => '80',
  docroot            => '/srv/http/friendica',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://friendica.strugee.net/',
}

apache::vhost { 'friendica.strugee.net ssl':
  servername         => 'friendica.strugee.net',
  port               => '443',
  docroot            => '/srv/http/friendica',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/friendica.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  access_log_format  => '%v:%p %h %l %u %t \"%m %U\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"',
  options	     => ['All'],
  override	     => 'all',
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'huginn.strugee.net plaintext':
  servername         => 'huginn.strugee.net',
  port               => '80',
  docroot            => '/srv/http/huginn',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://huginn.strugee.net/',
}

apache::vhost { 'huginn.strugee.net ssl':
  servername         => 'huginn.strugee.net',
  port               => '443',
  docroot            => '/srv/http/huginn/public',
  passenger_app_root => '/srv/http/huginn',
  passenger_app_env  => 'production',
  passenger_ruby     => '/usr/bin/ruby',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/huginn.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  ssl_cipher         => 'HIGH:MEDIUM:!aNULL:!MD5:!RC4',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'util.strugee.net plaintext':
  servername         => 'util.strugee.net',
  port               => '80',
  docroot            => '/var/empty',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://util.strugee.net/',
}

apache::vhost { 'util.strugee.net ssl':
  servername         => 'util.strugee.net',
  port               => '443',
  docroot            => '/var/empty',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/util.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  aliases            => [
    {
      alias          => '/phpmyadmin',
      path           => '/usr/share/phpmyadmin',
    }
  ],
  directories        => [
    {
      path           => '/var/empty',
      provider       => 'directory',
      require        => 'all granted',
    },
    {
      path           => '/usr/share/phpmyadmin',
      provider       => 'directory',
      options        => ['FollowSymLinks'],
      allow_override => 'all',
      require        => 'all granted',
      php_flag      => 'magic_quotes_gpc Off',
    },
    {
      path           => '/usr/share/phpmyadmin/libraries',
      provider       => 'directory',
      options        => ['FollowSymLinks'],
      allow_override => 'all',
      require        => 'all denied',
    },
    {
      path           => '/usr/share/phpmyadmin/setup/lib',
      provider       => 'directory',
      options        => ['FollowSymLinks'],
      allow_override => 'all',
      require        => 'all denied',
    },
    # TODO
    {
      path           => '/usr/share/phpmyadmin/setup',
      provider       => 'directory',
      options        => ['FollowSymLinks'],
      allow_override => 'all',
      require        => 'all denied',
    },
    {
      path           => '/server-status',
      provider       => 'location',
      sethandler     => 'server-status',
    },
  ],
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'pod.strugee.net plaintext':
  servername         => 'pod.strugee.net',
  port               => '80',
  docroot            => '/srv/http/diaspora/public',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://pod.strugee.net/',
}

apache::vhost { 'pod.strugee.net ssl':
  servername         => 'pod.strugee.net',
  port               => '443',
  docroot            => '/srv/http/diaspora/public',
  passenger_app_root => '/srv/http/diaspora',
  passenger_app_env  => 'production',
  passenger_ruby     => '/usr/bin/ruby',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/pod.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
}

apache::vhost { 'media.strugee.net plaintext':
  servername         => 'media.strugee.net',
  port               => '80',
  docroot            => '/srv/http/mediagoblin',
  redirect_status    => 'permanent',
  redirect_dest      => 'https://media.strugee.net/',
}

apache::vhost { 'media.strugee.net ssl':
  servername         => 'media.strugee.net',
  port               => '443',
  docroot            => '/srv/http/mediagoblin',
  ssl                => true,
  ssl_cert           => '/etc/ssl/certs/media.strugee.net.pem',
  ssl_key            => '/etc/ssl/private/mailserver.pem',
  ssl_chain          => '/etc/ssl/certs/StartSSL_Class1.pem',
  block              => 'scm',
  ssl_protocol       => 'all -SSLv2 -SSLv3',
  aliases            => [
    { alias          => '/mgoblin_static/',
      path           => '/srv/http/mediagoblin/mediagoblin/static/',
    },
    { alias          => '/mgoblin_media/',
      path           => '/var/lib/mediagoblin/media/public/',
    },
    { alias          => '/theme_static/',
      path           => '/srv/http//mediagoblin/user_dev/theme_static/',
    },
    { alias          => '/plugin_static/',
      path           => '/srv/http/mediagoblin/user_dev/plugin_static/',
    },
  ],
  wsgi_script_aliases => {
    '/'              => '/srv/http/mediagoblin/wsgi.py',
  },
  wsgi_daemon_process => 'gmg',
  wsgi_daemon_process_options =>
  {
    user              => 'mediagoblin',
    group             => 'mediagoblin',
    processes         => '2',
    threads           => '10',
    umask             => '0007',
    inactivity-timeout => '900',
    maximum-requests  => '1000',
    python-path       => '/srv/http/mediagoblin/:/srv/http/mediagoblin/lib/python2.7/site-packages/',
  },
  wsgi_pass_authorization => 'On',
  wsgi_application_group => '%{GLOBAL}',
  wsgi_process_group  => 'gmg',
  headers             => [
    'set X-Content-Type-Options: nosniff',
    'set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',

  ],
  directories        => [
    {
      path           => '/srv/http/mediagoblin/static',
      provider       => 'directory',
      require        => 'all granted',
    },
    {
      path           => '/srv/http/mediagoblin/user_dev/media/public',
      provider       => 'directory',
      require        => 'all granted',
    },
    {
      path           => '/srv/http/mediagoblin/user_dev/theme_static',
      provider       => 'directory',
      require        => 'all granted',
    },
    {
      path           => '/srv/http/mediagoblin/user_dev/plugin_static',
      provider       => 'directory',
      require        => 'all granted',
    },
  ],
}

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
#   headers             => 'Set Strict-Transport-Security: "max-age=31536000; includeSubDomains; preload"',
# }

apache::vhost { 'tumblr.strugee.net':
  servername      => 'tumblr.strugee.net',
  port            => '80',
  docroot         => '/var/empty',
  rewrites        => [ { rewrite_rule => ['^.*$ - [G]'] } ],
}
