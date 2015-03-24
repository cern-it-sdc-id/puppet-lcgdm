class lcgdm::rfio::service () inherits lcgdm::rfio::params {
  Class[Lcgdm::Rfio::Install] -> Class[Lcgdm::Rfio::Service]

  service { 'rfiod':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => 'rfiod',
    subscribe  => File['/etc/sysconfig/rfiod'],
  }
}
