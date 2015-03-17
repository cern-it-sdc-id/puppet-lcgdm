class lcgdm::dli::install () inherits lcgdm::dli::params {
  Class[Lcgdm::Dli::Config] -> Class[Lcgdm::Dli::Install]

  package { 'lfc-dli': ensure => present; }
}
