class lcgdm::rfio::install () inherits lcgdm::rfio::params {
  Class[lcgdm::rfio::config] -> Class[lcgdm::rfio::install]

  package { 'dpm-rfio-server': ensure => present; }

  file {
    '/var/log/rfio':
      ensure => directory,
      owner  => $lcgdm::base::config::user,
      group  => $lcgdm::base::config::user,
      mode   => '0755';

    '/var/log/rfio/log':
      ensure  => present,
      owner   => $lcgdm::base::config::user,
      group   => $lcgdm::base::config::user,
      mode    => '0644',
      require => File['/var/log/rfio'];
  }
}
