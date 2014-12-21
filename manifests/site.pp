
exec { 'update-packages':
  command => '/usr/bin/yum update -y',
  creates => '/vagrant/.locks/update-packages',
}

#
# Add the GPG key to our system
#
exec { 'elasticsearch-repo-gpg-key':
  command => '/bin/rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  creates => '/vagrant/.locks/add-elasticsearch-repo',
  require => Exec['update-packages']
}

#
# Update our yum repository
# TODO: Only perform this on Centos/Fedora/RedHat
file { 'elasticsearch.repo':
  path    => '/etc/yum.repos.d/elasticsearch.repo',
  ensure  => file,
  require => Exec['elasticsearch-repo-gpg-key'],
  source  => '/vagrant/manifests/elasticsearch.repo'
}


#
# TODO: Multiple Nodes for Elastic Search
#
#node "boundary-elastic-search" {

 class { 'boundary':
    token => '<api token>'
  }

  class { 'java':
    distribution => 'jdk',
  }

  class { 'elasticsearch':
    ensure => 'present',
    require => [File['elasticsearch.repo'], Class['java']]
  }

#}
