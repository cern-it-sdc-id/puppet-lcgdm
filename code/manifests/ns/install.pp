class lcgdm::ns::install (
) inherits lcgdm::ns::params {

    Class[Lcgdm::Ns::Config] -> Class[Lcgdm::Ns::Install]

    package { $lcgdm::ns::config::pkg:
            ensure => present;
    }

    file {
      "/var/log/$lcgdm::ns::config::flavor":
        ensure  => directory,
        owner   => $lcgdm::base::config::user,
        group   => $lcgdm::base::config::user,
        mode    => 755;
      "/var/log/$lcgdm::ns::config::flavor/log":
        ensure  => present,
        owner   => $lcgdm::base::config::user,
        group   => $lcgdm::base::config::user,
        mode    => 600,
        require => File["/var/log/$lcgdm::ns::config::flavor"];
    }

    validate_bool($lcgdm::ns::config::dbmanage)
    if $lcgdm::ns::config::dbmanage and $lcgdm::ns::config::dbflavor == "mysql" {
      Class[Lcgdm::Ns::Mysql] -> Class[Lcgdm::Ns::Service]
      class{"lcgdm::ns::mysql":
        flavor  => $lcgdm::ns::config::flavor,
        dbuser  => $lcgdm::ns::config::dbuser,
        dbpass  => $lcgdm::ns::config::dbpass,
        dbhost  => $lcgdm::ns::config::dbhost,
        require => Package[$lcgdm::ns::config::pkg]
      }
    }

}
