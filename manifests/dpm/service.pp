class lcgdm::dpm::service (
) inherits lcgdm::dpm::params {

	Class[Lcgdm::Dpm::Install] -> Class[Lcgdm::Dpm::Service]

   	service {'dpm':
     		ensure     	=> running,
    		enable		=> true,
     		hasrestart 	=> true,
     		hasstatus  	=> true,
     		name	        => 'dpm',
     		subscribe  	=> File["${configfile}"],
   	}
}
