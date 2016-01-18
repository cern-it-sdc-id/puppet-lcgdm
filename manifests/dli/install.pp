class lcgdm::dli::install () inherits lcgdm::dli::params {
  Class[lcgdm::dli::config] -> Class[lcgdm::dli::install]

  package { 'lfc-dli': ensure => present; }
}
