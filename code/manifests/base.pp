class lcgdm::base (
  $dpmuid          = $lcgdm::base::params::uid,
  $dpmgid          = $lcgdm::base::params::gid
) inherits lcgdm::dpm::params {
  ensure_resource('class', 'lcgdm::base::config', { uid => $dpmuid, gid => $dpmgid, })
  ensure_resource('class', 'lcgdm::base::install', { })
  #include('lcgdm::base::config')
  #include('lcgdm::base::install')
}
