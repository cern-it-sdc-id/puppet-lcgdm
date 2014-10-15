class lcgdm::base (
  $uid          = $lcgdm::base::params::uid,
  $gid          = $lcgdm::base::params::gid,
  $cert         = $lcgdm::base::params::cert,
  $certkey      = $lcgdm::base::params::certkey,
  $user         = $lcgdm::base::params::user,
) inherits lcgdm::dpm::params {
  class{"lcgdm::base::config":
    uid => $uid,
    gid => $gid,
    cert => $cert,
    certkey => $certkey,
    user => $user,
  }
  class{"lcgdm::base::install":}
}
