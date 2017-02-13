class lcgdm::ns::service ($dbmanage = $lcgdm::ns::params::dbmanage, $dbflavor = $lcgdm::ns::params::dbflavor) inherits lcgdm::ns::params {
  Class[lcgdm::ns::install] -> Class[lcgdm::ns::service]

  Class[lcgdm::base::config] ->  Class[lcgdm::ns::service]
  
  service { "${lcgdm::ns::config::daemon}":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => "${lcgdm::ns::config::daemon}",
    subscribe  => File["${configfile}", "/etc/sysconfig/${lcgdm::ns::config::daemon}",
		"/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::cert",
		"/etc/grid-security/$lcgdm::base::config::user/$lcgdm::base::config::certkey"],
  }


 #centOS7 changes
 if $::operatingsystemmajrelease and ($::operatingsystemmajrelease + 0) >= 7 {
   case $lcgdm::ns::config::daemon {
    dpnsdaemon : {
      file{'/etc/systemd/system/multi-user.target.wants/dpnsdaemon.service':
        ensure => 'link',
        target => '/usr/share/dpm-mysql/dpnsdaemon.service',
      } ->
      file{'/etc/systemd/system/dpnsdaemon.service':
        ensure => link,
        target => '/usr/share/dpm-mysql/dpnsdaemon.service',
      } -> Service['dpnsdaemon']
    }
    lfcdaemon : {
      file{'/etc/systemd/system/multi-user.target.wants/lfcdaemon.service':
        ensure => 'link',
        target => '/usr/share/lfc-mysql/lfcdaemon.service',
      } ->
      file{'/etc/systemd/system/lfcdaemon.service':
        ensure => link,
        target => '/usr/share/lfc-mysql/lfcdaemon.service',
      } ->  Service['lfcdaemon']
    }
  }
 }

}
