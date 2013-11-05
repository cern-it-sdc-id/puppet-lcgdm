class lcgdm::dpm::config (
  $host         = $lcgdm::dpm::params::host,
  $nshost       = $lcgdm::dpm::params::nshost,
  $dbflavor     = $lcgdm::dpm::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost       = $lcgdm::dpm::params::dbhost,
  $dbmanage     = $lcgdm::dpm::params::dbmanage,
  $active       = $lcgdm::dpm::params::active,
  $ulimitn      = $lcgdm::dpm::params::ulimitn,
  $coredump     = $lcgdm::dpm::params::coredump,
  $syncget      = $lcgdm::dpm::params::syncget,
  $numfthreads  = $lcgdm::dpm::params::numfthreads,
  $numsthreads  = $lcgdm::dpm::params::numsthreads,
  $configfile   = $lcgdm::dpm::params::configfile
) inherits lcgdm::dpm::params {

  Class[Lcgdm::Base::Config] -> Class[Lcgdm::Dpm::Config]

  file {
    "$configfile": # "/usr/etc/DPMCONFIG"
      ensure  => present,
      owner   => $lcgdm::base::config::user,
      group   => $lcgdm::base::config::user,
      mode    => 600,
      content => template("lcgdm/dpm/config.erb"),
      require => User[$lcgdm::base::config::user];
    "/etc/sysconfig/dpm":
      owner   => root,
      group   => root,
      mode    => 644,
      content => template("lcgdm/dpm/sysconfig.erb");
  }

}

