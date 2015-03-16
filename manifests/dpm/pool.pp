define lcgdm::dpm::pool($def_filesize = "100M") {

  Class[Lcgdm::Ns::Client] -> Lcgdm::Dpm::Pool <| |>

  exec{"lcgdm_dpm_pool-${name}":
    path => "/bin:/sbin:/usr/bin:/usr/sbin",
    environment => ["CSEC_MECH=ID", "DPM_HOST=${lcgdm::dpm::config::host}", "DPM_CONNTIMEOUT=1", "DPM_CONRETRY=1", "DPM_CONRETRYINT=1"
      ],
    command     => "dpm-addpool --poolname '${name}' --def_filesize $def_filesize",
    unless      => "dpm-qryconf | grep 'POOL ${name}'",
    require => Class["lcgdm::dpm::service"]
  }

}
