define lcgdm::ns::vo ($domain) {
  Class[Lcgdm::Ns::Client] -> Lcgdm::Ns::Vo <| |>

  Lcgdm::Ns::Domain[$domain] -> Lcgdm::Ns::Vo[$name]

  $envhost = "${lcgdm::ns::config::envvar}_HOST"
  $envtimeout = "${lcgdm::ns::config::envvar}_CONNTIMEOUT"
  $envretry = "${lcgdm::ns::config::envvar}_CONNRETRY"
  $envretryint = "${lcgdm::ns::config::envvar}_CONNRETRYINT"

  $domainpath = "/${lcgdm::ns::config::basepath}/${domain}"
  $vopath = "/${domainpath}/home/${name}"

  exec { "ns_vo_${domain}_${name}":
    path        => '/usr/bin:/usr/sbin',
    environment => [
      'CSEC_MECH=ID',
      "${envhost}=${lcgdm::ns::config::host}",
      "${envtimeout}=1",
      "${envretry}=1",
      "${envretryint}=1"],
    command     => "${lcgdm::ns::config::flavor}-mkdir -p ${vopath}; ${lcgdm::ns::config::flavor}-chmod 755 ${vopath}; ${lcgdm::ns::config::flavor}-entergrpmap --group ${name}; ${lcgdm::ns::config::flavor}-chown root:${name} ${vopath}; ${lcgdm::ns::config::flavor}-chmod 775 ${vopath}",
    unless      => "${lcgdm::ns::config::flavor}-ls ${vopath}",
  } ->
  exec { "ns_basepath_setacl-dpnsbasedir-${domain}-${name}":
    path        => '/usr/bin:/usr/sbin:/bin',
    environment => [
      'CSEC_MECH=ID',
      "${envhost}=${lcgdm::ns::config::host}",
      "${envtimeout}=1",
      "${envretry}=1",
      "${envretryint}=1"],
    command     => "${lcgdm::ns::config::flavor}-setacl -m d:u::7,d:g::7,d:o:5 ${domainpath}/home",
    unless      => "${lcgdm::ns::config::flavor}-getacl -d ${domainpath}/home |  grep user::",
  } ->
  exec { "ns_vopath_setacl-${domain}-${name}":
    path        => '/usr/bin:/usr/sbin:/bin',
    environment => [
      'CSEC_MECH=ID',
      "${envhost}=${lcgdm::ns::config::host}",
      "${envtimeout}=1",
      "${envretry}=1",
      "${envretryint}=1"],
    command     => "${lcgdm::ns::config::flavor}-setacl -m d:u::7,d:g::7,d:o:5 ${vopath}",
    unless      => "${lcgdm::ns::config::flavor}-getacl -d ${vopath} |  grep user::",
  }
}
