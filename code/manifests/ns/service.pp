class lcgdm::ns::service (
) inherits lcgdm::ns::params {

   Class[Lcgdm::Ns::Install] -> Class[Lcgdm::Ns::Service]

   service { "${lcgdm::ns::config::daemon}":
     enable     => true,
     ensure     => running,
     hasrestart => true,
     hasstatus  => true,
     name       => "${lcgdm::ns::config::daemon}",
     subscribe  => File["/usr/etc/NSCONFIG", "/etc/sysconfig/${lcgdm::ns::config::daemon}"],
   }
}
