class lcgdm::dpm::service () inherits lcgdm::dpm::params {
  Class[lcgdm::dpm::install] -> Class[lcgdm::dpm::service]

  Class[lcgdm::base::config] ->  Class[lcgdm::dpm::service]

  service { 'dpm':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => 'dpm',
    subscribe  => File["${configfile}",
	          "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::cert",
                  "/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::certkey"],
  }

   #centOS7 changes
 if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 {

   file{'/etc/systemd/system/multi-user.target.wants/dpm.service':
     ensure => 'link',
     target => '/usr/share/dpm-mysql/dpm.service',
   }
   file{'/etc/systemd/system/dpm.service':
     ensure => link,
     target => '/usr/share/dpm-mysql/dpm.service',
   }
 }
}
