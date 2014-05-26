class lcgdm::base (
  $dpmuid          = $lcgdm::base::params::uid,
  $dpmgid          = $lcgdm::base::params::gid
) inherits lcgdm::dpm::params {
  class{"lcgdm::base::config":
    uid => $dpmuid,
    gid => $dpmgid,
  }
  class{"lcgdm::base::install":}
}
