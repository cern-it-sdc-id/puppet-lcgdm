define lcgdm::dpm::filesystem ($pool, $fs, $ensure = present, $dpmhost = $lcgdm::ns::client::dpmhost, $server = $fqdn,) {
  Class[lcgdm::ns::client] -> Lcgdm::Dpm::Filesystem <| |>

  if $dpmhost == undef {
    $host = $lcgdm::dpm::config::host
  } else {
    $host = $dpmhost
  }

  if $ensure == 'present' {
    $cmd = 'dpm-addfs'
    $grep = 'grep -q'
    $pool_option = "--poolname ${pool}"
  } else {
    $cmd = 'dpm-rmfs'
    $grep = '! grep -q'
    $pool_option = '' # dpm-rmfs does not need/accept --poolname
  }

  exec { "${pool}/${server}:${fs}":
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    environment => ['CSEC_MECH=ID', "DPM_HOST=${host}", 'DPM_CONNTIMEOUT=1', 'DPM_CONRETRY=1', 'DPM_CONRETRYINT=1'],
    command     => "${cmd} ${pool_option} --server ${server} --fs ${fs}",
    unless      => "dpm-qryconf | ( ${grep} '${server} ${fs}' )" # subshell required to invert return status with !
  }

}
