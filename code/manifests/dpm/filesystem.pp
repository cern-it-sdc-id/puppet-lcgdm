define lcgdm::dpm::filesystem($server = $fqdn, $pool, $fs) {

    Class[Lcgdm::Ns::Client] -> Lcgdm::Dpm::Filesystem <| |>

    exec{"$pool/$server:$fs":
      path        => "/bin:/sbin:/usr/bin:/usr/sbin",
      environment => ["DPM_HOST=${lcgdm::dpm::config::host}", "DPM_CONNTIMEOUT=1", "DPM_CONRETRY=1", "DPM_CONRETRYINT=1"
      ],
      command     => "dpm-addfs --poolname $pool --server $server --fs $fs",
      unless      => "dpm-qryconf | grep '$fqdn $fs'",
      require     => Class["lcgdm::dpm::service"]
    }

}
