$elasticsearch_pkg_name = $operatingsystem ? {
  centos => elasticsearch,
  default => openssl
}

#exec { 'update-packages':
#  command => '/usr/bin/yum update -y',
#  creates => '/vagrant/.locks/update-packages',
#}

exec { 'elasticsearch-repo-gpg-key':
  command => '/bin/rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  creates => '/vagrant/.locks/add-elasticsearch-repo',
#  require => Exec['update-packages']
}

file { 'elasticsearch.repo':
  path    => '/etc/yum.repos.d/elasticsearch.repo',
  ensure  => file,
  require => Exec['elasticsearch-repo-gpg-key'],
  source  => '/vagrant/manifests/elasticsearch.repo'
}

package { 'jdk':
  name => 'java-1.7.0-openjdk',
  allow_virtual => false,
  ensure => 'latest',
  require => File['elasticsearch.repo']
}

package { 'elasticsearch':
  name => 'elasticsearch',
  allow_virtual => false,
  ensure => 'latest',
  require => Package['jdk']
}

class { 'boundary':
  token => 'api_token'
}

