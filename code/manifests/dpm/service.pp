class lcgdm::dpm::service (
) inherits lcgdm::dpm::params {

   Class[Lcgdm::Dpm::Install] -> Class[Lcgdm::Dpm::Service]

   service { "dpm":
     enable     => true,
     ensure     => running,
     hasrestart => true,
     hasstatus  => true,
     name       => "dpm",
     subscribe  => File["/etc/sysconfig/dpm"],
   }
}
