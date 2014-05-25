class { 'mediawiki' :
  server_name       => 'wiki.strugee.net',
  admin_email       => 'alexander3223098@gmail.com',
  db_root_password  => 'strong password',
  doc_root          => '/srv/wiki/',
  max_memory        => '1024',
}

mediawiki::instance { 'strugee.net wiki':
  db_password       => 'strong password',
  db_name           => 'wiki',
  db_user           => 'wiki',
  port              => '8080',
  ensure            => 'present',
}
