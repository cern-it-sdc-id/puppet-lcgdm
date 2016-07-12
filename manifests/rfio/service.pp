class lcgdm::rfio::service () inherits lcgdm::rfio::params {
  Class[lcgdm::rfio::install] -> Class[lcgdm::rfio::service]
  
  Class[lcgdm::base::config] ->  Class[lcgdm::rfio::service]

  service { 'rfiod':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => 'rfiod',
    subscribe  => File['/etc/sysconfig/rfiod',
                  "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::cert",
                  "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::certkey"],
		
  }
}
