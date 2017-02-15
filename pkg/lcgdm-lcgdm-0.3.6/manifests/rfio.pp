class lcgdm::rfio ($dpmhost = $::fqdn, $nshost = undef,) {
  Class[lcgdm::base::config] -> Class[lcgdm::rfio::config]

  $_nshost = $nshost ? {
	undef	=> $dpmhost,
	default	=> $nshost,
  }
	
  class { 'lcgdm::rfio::config':
    dpmhost => $dpmhost,
    nshost  => $_nshost,
  }

  class { 'lcgdm::rfio::install':
  }

  class { 'lcgdm::rfio::service':
  }
}
