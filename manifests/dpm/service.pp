class lcgdm::dpm::service () inherits lcgdm::dpm::params {
  Class[Lcgdm::Dpm::Install] -> Class[Lcgdm::Dpm::Service]

  service { 'dpm':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => 'dpm',
    subscribe  => File["${configfile}"],
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
