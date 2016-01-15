class lcgdm::rfio::service () inherits lcgdm::rfio::params {
  Class[lcgdm::rfio::install] -> Class[lcgdm::rfio::service]

  service { 'rfiod':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => 'rfiod',
    subscribe  => File['/etc/sysconfig/rfiod'],
  }
}
