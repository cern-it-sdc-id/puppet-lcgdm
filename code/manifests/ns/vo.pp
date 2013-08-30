define lcgdm::ns::vo($domain) {

    Class[Lcgdm::Ns::Client] -> Lcgdm::Ns::Vo <| |>

    Lcgdm::Ns::Domain[$domain] -> Lcgdm::Ns::Vo[$name]

    $envhost     = "${lcgdm::ns::config::envvar}_HOST"
    $envtimeout  = "${lcgdm::ns::config::envvar}_CONNTIMEOUT"
    $envretry    = "${lcgdm::ns::config::envvar}_CONNRETRY"
    $envretryint = "${lcgdm::ns::config::envvar}_CONNRETRYINT"

    $vopath = "/${lcgdm::ns::config::basepath}/$domain/home/$name"

    exec { "ns_vo_$domain_$name":
      path        => "/usr/bin:/usr/sbin",
      environment => ["CSEC_MECH=ID", "$envhost=${lcgdm::ns::config::host}", "$envtimeout=1", "$envretry=1", "$envretryint=1"],
      command     => "${lcgdm::ns::config::flavor}-mkdir -p $vopath; ${lcgdm::ns::config::flavor}-chmod 755 $vopath; ${lcgdm::ns::config::flavor}-entergrpmap --group $name; ${lcgdm::ns::config::flavor}-chown root:$name $vopath; ${lcgdm::ns::config::flavor}-chmod 775 $vopath",
      unless      => "${lcgdm::ns::config::flavor}-ls $vopath",
    }

}
