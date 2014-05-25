class apache::site-contents {

  include git

  git::repo { 'strugee.github.com':
    path   => '/srv/http/default',
    source => 'https://github.com/strugee/strugee.github.com.git',
    branch => 'master',
    update => true,
  }

}

include apache::site-contents
