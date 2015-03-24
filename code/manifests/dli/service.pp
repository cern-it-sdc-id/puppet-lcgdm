class lcgdm::dli::service () inherits lcgdm::dli::params {
  Class[Lcgdm::Dli::Install] -> Class[Lcgdm::Dli::Service]

  service { 'lfc-dli':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File['/etc/sysconfig/lfc-dli'],
  }
}

