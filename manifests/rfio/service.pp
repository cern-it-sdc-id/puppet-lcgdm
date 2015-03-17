class lcgdm::rfio::service (
) inherits lcgdm::rfio::params {

  Class[Lcgdm::Rfio::Install] -> Class[Lcgdm::Rfio::Service]

  service {'rfiod':
    enable     => true,
    ensure     => running,
    hasrestart => true,
    hasstatus  => true,
    name       => 'rfiod',
    subscribe  => File['/etc/sysconfig/rfiod'],
  }
}
