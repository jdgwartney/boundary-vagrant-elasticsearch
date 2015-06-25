# Explictly set to avoid warning message
Package {
  allow_virtual => false,
}

package {'epel-release':
  ensure => 'installed',
  require => Exec['update-packages']
}

package {'jq':
  ensure => 'installed',
  require => Package['epel-release']
}

exec { 'update-packages':
  command => '/usr/bin/yum update -y',
  creates => '/vagrant/.locks/update-packages',
}

# Add the GPG key to our system
exec { 'elasticsearch-repo-gpg-key':
  command => '/bin/rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  creates => '/vagrant/.locks/add-elasticsearch-repo',
  require => Exec['update-packages']
}

# Update our yum repository
file { 'elasticsearch.repo':
  path    => '/etc/yum.repos.d/elasticsearch.repo',
  ensure  => file,
  require => Exec['elasticsearch-repo-gpg-key'],
  source  => '/vagrant/manifests/elasticsearch.repo'
}

file { 'bash_profile':
  path    => '/home/vagrant/.bash_profile',
  ensure  => file,
  require => Class['elasticsearch'],
  source  => '/vagrant/manifests/bash_profile'
}

node default {

  class { 'boundary':
    token => '<api token>'
  }

  class { 'java':
    distribution => 'jdk',
  }

  class { 'elasticsearch':
    config => { 'cluster.name' => 'boundary' },
    require => [File['elasticsearch.repo'], Class['java']]
  }

  elasticsearch::instance { 'd':
    config => { 'node.master' => 'true', 'node.data' => 'true', 'cluster.name' => 'boundary'},
  }
}
