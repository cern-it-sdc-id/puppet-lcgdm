define lcgdm::ns::domain() {

    Class[Lcgdm::Ns::Client] -> Lcgdm::Ns::Domain <| |>

    $envhost     = "${lcgdm::ns::config::envvar}_HOST"
    $envtimeout  = "${lcgdm::ns::config::envvar}_CONNTIMEOUT"
    $envretry    = "${lcgdm::ns::config::envvar}_CONNRETRY"
    $envretryint = "${lcgdm::ns::config::envvar}_CONNRETRYINT"

    $domainpath = "/${lcgdm::ns::config::basepath}/$name"

    exec { "ns_domain_${lcgdm::ns::config::host}-$name":
      path        => "/usr/bin:/usr/sbin",
      environment => ["CSEC_MECH=ID", "$envhost=${lcgdm::ns::config::host}", "$envtimeout=1", "$envretry=1", "$envretryint=1"],
      command     => "${lcgdm::ns::config::flavor}-mkdir -p $domainpath",
      unless      => "${lcgdm::ns::config::flavor}-ls $domainpath",
    }
    ->
    exec {"ns_basepath_setacl-$name":
      path        => "/usr/bin:/usr/sbin:/bin",
      environment => ["CSEC_MECH=ID", "$envhost=${lcgdm::ns::config::host}", "$envtimeout=1", "$envretry=1", "$envretryint=1"],
      command     => "${lcgdm::ns::config::flavor}-setacl -m d:u::7,d:g::7,d:o:5 /${lcgdm::ns::config::basepath}",
      unless      => "${lcgdm::ns::config::flavor}-getacl -d /${lcgdm::ns::config::basepath} |  grep user::",
    }
    ->
    exec {"ns_basepath_setacl-domain-$name":
      path        => "/usr/bin:/usr/sbin:/bin",
      environment => ["CSEC_MECH=ID", "$envhost=${lcgdm::ns::config::host}", "$envtimeout=1", "$envretry=1", "$envretryint=1"],
      command     => "${lcgdm::ns::config::flavor}-setacl -m d:u::7,d:g::7,d:o:5 $domainpath",
      unless      => "${lcgdm::ns::config::flavor}-getacl -d $domainpath |  grep user::",
    }

}
