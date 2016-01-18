class lcgdm::ns::service ($dbmanage = $lcgdm::ns::params::dbmanage, $dbflavor = $lcgdm::ns::params::dbflavor) inherits lcgdm::ns::params {
  Class[lcgdm::ns::install] -> Class[lcgdm::ns::service]

  service { "${lcgdm::ns::config::daemon}":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => "${lcgdm::ns::config::daemon}",
    subscribe  => File["${configfile}", "/etc/sysconfig/${lcgdm::ns::config::daemon}"],
  }

 #centOS7 changes
 if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 {
   file{'/etc/systemd/system/multi-user.target.wants/dpnsdaemon.service':
     ensure => 'link',
     target => '/usr/share/dpm-mysql/dpnsdaemon.service',
   }
   file{'/etc/systemd/system/dpnsdaemon.service':
     ensure => link,
     target => '/usr/share/dpm-mysql/dpnsdaemon.service',
   }
 }
}
