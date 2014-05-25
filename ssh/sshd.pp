package { 'openssh-server':
  ensure       => latest,
  before       => File['/etc/ssh/sshd_config'],
}

file { '/etc/ssh/sshd_config':
  ensure       => file,
  mode         => '0644',
  source       => '/home/alex/Development/steevie/infrastructure/ssh/sshd_config',
}

service { 'ssh':
  ensure       => running,
  enable       => true,
  require      => Package['openssh-server'],
  subscribe    => File['/etc/ssh/sshd_config'],
}
