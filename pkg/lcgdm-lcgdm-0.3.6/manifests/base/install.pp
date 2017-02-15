class lcgdm::base::install () inherits lcgdm::base::params {
  Class[lcgdm::base::config] -> Class[lcgdm::base::install]

  package { 'lcgdm-libs': ensure => present; }

  ensure_packages(['finger'])

  if $lcgdm::base::config::egiCA {
    ensure_packages(['ca-policy-egi-core'])
  }
}
