class lcgdm::base::install (
) inherits lcgdm::base::params {

    Class[Lcgdm::Base::Config] -> Class[Lcgdm::Base::Install]

    package {
        "lcgdm-libs":
            ensure => present;
    }

    ensure_resource('package', 'finger', {'ensure' => 'present'})

    ensure_resource('package', 'ca-policy-egi-core', {'ensure' => 'present'})
}
