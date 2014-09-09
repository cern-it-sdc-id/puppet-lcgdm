class lcgdm::base (
  $uid          = $lcgdm::base::params::uid,
  $cert         = $lcgdm::base::params::cert,
  $certkey      = $lcgdm::base::params::certkey,
  $user         = $lcgdm::base::params::user,
) inherits lcgdm::dpm::params {
  class{"lcgdm::base::config":
    uid => $uid,
    gid => $uid,
    cert => $cert,
    certkey => $certkey,
    user => $user,
  }
  class{"lcgdm::base::install":}
}
