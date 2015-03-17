class lcgdm::base::install (
) inherits lcgdm::base::params {

    Class[Lcgdm::Base::Config] -> Class[Lcgdm::Base::Install]

    package {
        'lcgdm-libs':
            ensure => present;
    }

    ensure_packages(['finger'])

    if $lcgdm::base::config::egiCA {
      ensure_packages(['ca-policy-egi-core'])
    }
}
