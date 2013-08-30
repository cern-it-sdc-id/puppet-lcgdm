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

}
