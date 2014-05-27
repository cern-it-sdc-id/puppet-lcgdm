class lcgdm::base (
  $uid          = $lcgdm::base::params::uid,
) inherits lcgdm::dpm::params {
  class{"lcgdm::base::config":
    uid => $uid,
    gid => $uid,
  }
  class{"lcgdm::base::install":}
}
