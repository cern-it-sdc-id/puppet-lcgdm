class lcgdm::base::install (
) inherits lcgdm::base::params {

    Class[Lcgdm::Base::Config] -> Class[Lcgdm::Base::Install]

    package { 
        "lcgdm-libs": 
            ensure => present;
    }

}
