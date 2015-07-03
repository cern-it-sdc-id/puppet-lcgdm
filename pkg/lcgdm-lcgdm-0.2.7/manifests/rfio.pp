class lcgdm::rfio ($dpmhost = "${::fqdn}", $nshost = "${dpmhost}",) {
  Class[Lcgdm::Base::Config] -> Class[Lcgdm::Rfio::Config]

  class { 'lcgdm::rfio::config':
    dpmhost => "${dpmhost}",
    nshost  => "${nshost}",
  }

  class { 'lcgdm::rfio::install':
  }

  class { 'lcgdm::rfio::service':
  }
}
