class lcgdm::dli::service () inherits lcgdm::dli::params {
  Class[lcgdm::dli::install] -> Class[lcgdm::dli::service]

  service { 'lfc-dli':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => File['/etc/sysconfig/lfc-dli'],
  }
}

