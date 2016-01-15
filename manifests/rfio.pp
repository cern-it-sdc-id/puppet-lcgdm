class lcgdm::rfio ($dpmhost = "${::fqdn}", $nshost = "${dpmhost}",) {
  Class[lcgdm::base::config] -> Class[lcgdm::rfio::config]

  class { 'lcgdm::rfio::config':
    dpmhost => "${dpmhost}",
    nshost  => "${nshost}",
  }

  class { 'lcgdm::rfio::install':
  }

  class { 'lcgdm::rfio::service':
  }
}
