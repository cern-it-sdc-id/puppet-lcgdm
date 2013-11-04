class lcgdm::rfio::config (
  $active       = $lcgdm::rfio::params::active,
  $ulimitn      = $lcgdm::rfio::params::ulimitn,
  $coredump     = $lcgdm::rfio::params::coredump,
  $portrange    = $lcgdm::rfio::params::portrange,
  $startoptions = $lcgdm::rfio::params::startoptions,
  $nshost       = $lcgdm::rfio::params::nshost,
  $dpmhost      = $lcgdm::rfio::params::dpmhost
) inherits lcgdm::rfio::params {

  Class[Lcgdm::Base::Config] -> Class[Lcgdm::Rfio::Config]

  file {
    "/etc/sysconfig/rfiod":
      owner  => root,
      group  => root,
      mode   => 644,
      content => template("lcgdm/rfio/sysconfig.erb");
  }

}

