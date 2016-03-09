class lcgdm::rfio ($dpmhost = $::fqdn, $nshost = undef,) {
  Class[lcgdm::base::config] -> Class[lcgdm::rfio::config]

  if ($nshost == undef){
	$nshost = $dpmhost
  }
	
  class { 'lcgdm::rfio::config':
    dpmhost => $dpmhost,
    nshost  => $nshost,
  }

  class { 'lcgdm::rfio::install':
  }

  class { 'lcgdm::rfio::service':
  }
}
