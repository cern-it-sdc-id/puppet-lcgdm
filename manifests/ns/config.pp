class lcgdm::ns::config (
  $flavor          = $lcgdm::ns::params::flavor,
  $host            = $lcgdm::ns::params::host,
  $dbflavor        = $lcgdm::ns::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost          = $lcgdm::ns::params::dbhost,
  $dbmanage        = $lcgdm::ns::params::dbmanage,
  $active          = $lcgdm::ns::params::active,
  $readonly        = $lcgdm::ns::params::readonly,
  $disableautovids = $lcgdm::ns::params::disableautovids,
  $ulimitn         = $lcgdm::ns::params::ulimitn,
  $coredump        = $lcgdm::ns::params::coredump,
  $numthreads      = $lcgdm::ns::params::numthreads,
  $configfile      = $lcgdm::ns::params::configfile,
  $logpermissions  = $lcgdm::ns::params::logpermissions,) inherits lcgdm::ns::params {
  Class[Lcgdm::Base::Config] -> Class[Lcgdm::Ns::Config]

  case $flavor {
    cns  : {
      $daemon = 'nsdaemon'
      $envvar = 'CNS'
      $basepath = 'castor'
      $pkg = "cns-server-${dbflavor}"
      $clientpkg = 'cns'
    }
    dpns : {
      $daemon = 'dpnsdaemon'
      $envvar = 'DPNS'
      $basepath = 'dpm'
      $pkg = "dpm-name-server-${dbflavor}"
      $clientpkg = 'dpm'
    }
    lfc  : {
      $daemon = 'lfcdaemon'
      $envvar = 'LFC'
      $basepath = 'grid'
      $pkg = "lfc-server-${dbflavor}"
      $clientpkg = 'lfc'
    }
  }

  file {
    "$configfile":
      ensure  => present,
      owner   => $lcgdm::base::config::user,
      group   => $lcgdm::base::config::user,
      mode    => '0600',
      content => template("lcgdm/ns/config.erb"),
      require => User[$lcgdm::base::config::user];

    "/etc/sysconfig/${daemon}":
      owner   => root,
      group   => root,
      mode    => '0644',
      content => template("lcgdm/ns/sysconfig.erb");
  }

}

